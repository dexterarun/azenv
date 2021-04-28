resource "azurerm_resource_group" "vnet_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-networking"
  location = var.loc.long
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-aks"
  location = var.loc.long
}

module "networking" {
    source = "./modules/networking/"
    prefix = var.prefix
    env = var.env    
    vnet_rg = azurerm_resource_group.vnet_rg.name
    vnet_loc = var.loc
    vnet_addr_space = var.vnet_addr_space
    vnet_subnets = var.vnet_subnets
}
