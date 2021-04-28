resource "azurerm_network_security_group" "default_nsg" {
  name                = "${var.prefix}-${var.env}-${var.vnet_loc.short}"
  location            = var.vnet_loc.long
  resource_group_name = var.vnet_rg
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-${var.env}-${var.vnet_loc.short}"
  location            = var.vnet_loc.long
  resource_group_name = var.vnet_rg
  address_space       = var.vnet_addr_space
  
  tags = {
    product = var.prefix
    environment = var.env
  }
}

resource "azurerm_subnet" "subnets" {
  count = length(var.vnet_subnets)
  name                 = "${var.prefix}-${var.env}-${var.vnet_loc.short}-${lookup(var.vnet_subnets[count.index], "name")}"
  resource_group_name = var.vnet_rg
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = lookup(var.vnet_subnets[count.index], "cidr")
}

# resource "azurerm_subnet_network_security_group_association" "subnet_security_group_association" {   
#   subnet_id                 = azurerm_subnet.subnets.*.id
#   network_security_group_id = azurerm_network_security_group.example.id
# }