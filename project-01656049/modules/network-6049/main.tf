resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  location            = var.location
  resource_group_name = var.rg
  address_space       = var.vnet_space
  tags                = var.common_tags
}
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet
  resource_group_name  = var.rg
  virtual_network_name = var.vnet
  address_prefixes     = var.subnet_space
  depends_on           = [azurerm_virtual_network.vnet]
}
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg
  location            = var.location
  resource_group_name = var.rg

  security_rule {
    name                       = "${var.humberid}-rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "${var.humberid}-rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "${var.humberid}-rule3"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "${var.humberid}-rule4"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on                = [azurerm_subnet.subnet, azurerm_network_security_group.nsg]
}
