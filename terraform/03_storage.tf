// Storage
resource "azurerm_resource_group" "sg_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-storage"
  location = var.loc.long
}

module "storage" {
  source  = "./modules/storage/"
  
  prefix  = var.prefix
  env     = var.env
  rg_name = azurerm_resource_group.sg_rg.name
  loc     = var.loc

  sg_name_suffix = "default"
}