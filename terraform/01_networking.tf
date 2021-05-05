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

data "azurerm_subnet" "vnet_gw_subnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = module.networking.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
}

module "gateways" {
  source = "./modules/gateways"
  
  res_prefix = module.networking.vnet.name
  
  prefix          = var.prefix
  env             = var.env
  rg_name         = azurerm_resource_group.vnet_rg.name
  loc             = var.loc

  gw_subnet_id = data.azurerm_subnet.vnet_gw_subnet.id
  gw_addr_space = ["10.0.100.0/24"]
  
}