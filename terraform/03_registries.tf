// ACR
resource "azurerm_resource_group" "acr_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-registry"
  location = var.loc.long
}

module "acr" {
  source  = "./modules/acr/"
  prefix  = var.prefix
  env     = var.env
  rg_name = azurerm_resource_group.acr_rg.name
  loc     = var.loc
}