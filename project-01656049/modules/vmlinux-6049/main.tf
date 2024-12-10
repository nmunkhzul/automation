resource "azurerm_availability_set" "avs" {
  name                         = var.avs_linux
  location                     = var.location
  resource_group_name          = var.rg
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.common_tags
}

resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.vmlinux_name
  name                = "${each.key}-pip"
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = each.key
  tags                = var.common_tags
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.vmlinux_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg
  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }
  tags       = var.common_tags
  depends_on = [azurerm_public_ip.linux_pip]
}

resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each              = var.vmlinux_name
  name                  = each.key
  resource_group_name   = var.rg
  location              = var.location
  size                  = var.linux_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]
  availability_set_id   = azurerm_availability_set.avs.id
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("/home/${lower(var.admin_username)}/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "32"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = var.storage_account.primary_blob_endpoint
  }
  tags = var.common_tags

  depends_on = [azurerm_availability_set.avs, azurerm_network_interface.linux_nic]
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each                   = var.vmlinux_name
  name                       = var.netwatcher_extension["type"]
  virtual_machine_id         = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher                  = var.netwatcher_extension["publisher"]
  type                       = var.netwatcher_extension["type"]
  type_handler_version       = var.netwatcher_extension["version"]
  auto_upgrade_minor_version = "true"

  depends_on = [azurerm_linux_virtual_machine.vmlinux, null_resource.linux_provisioner]
}

resource "azurerm_virtual_machine_extension" "monitor" {
  for_each                   = var.vmlinux_name
  name                       = var.monitor_extension["type"]
  virtual_machine_id         = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher                  = var.monitor_extension["publisher"]
  type                       = var.monitor_extension["type"]
  type_handler_version       = var.monitor_extension["version"]
  auto_upgrade_minor_version = "true"
  depends_on                 = [azurerm_linux_virtual_machine.vmlinux, null_resource.linux_provisioner]
}

