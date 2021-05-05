// Networking 
resource "azurerm_resource_group" "vnet_rg" {
  name     = "${local.res_prefix}-networking"
  location = var.loc.long
}

module "networking" {
  source          = "./modules/networking/"
  res_prefix = local.res_prefix
  prefix          = var.prefix
  env             = var.env
  rg_name         = azurerm_resource_group.vnet_rg.name
  loc             = var.loc
  vnet_addr_space = var.vnet_addr_space
  vnet_subnets    = var.vnet_subnets
 
}