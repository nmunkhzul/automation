resource "azurerm_public_ip" "lb_pip" {
  name                = var.lb_pip["name"]
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = var.lb_pip["allocation_method"]
  domain_name_label   = lower(var.lb["name"])
  tags                = var.common_tags
}

resource "azurerm_lb" "lb" {
  name                = var.lb["name"]
  location            = var.location
  resource_group_name = var.rg
  frontend_ip_configuration {
    name                 = var.lb_pip["name"]
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
  tags       = var.common_tags
  depends_on = [azurerm_public_ip.lb_pip]
}

resource "azurerm_lb_backend_address_pool" "lb_backerd_addr_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.lb["name"]}-backend-address-pool"
  depends_on      = [azurerm_lb.lb]
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_nic_pool" {
  for_each                = var.vmlinux_nics
  network_interface_id    = var.vmlinux_nics[each.key]
  ip_configuration_name   = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backerd_addr_pool.id
  depends_on              = [azurerm_lb_backend_address_pool.lb_backerd_addr_pool]
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.lb["name"]}-probe"
  port            = var.service_port
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "${var.lb["name"]}-rule"
  protocol                       = "Tcp"
  frontend_port                  = var.service_port
  backend_port                   = var.service_port
  disable_outbound_snat          = true
  frontend_ip_configuration_name = var.lb_pip["name"]
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backerd_addr_pool.id]
}

