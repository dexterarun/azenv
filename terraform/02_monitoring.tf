// Monitoring
resource "azurerm_resource_group" "monitoring_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-monitoring"
  location = var.loc.long
}

module "monitoring" {
  source  = "./modules/monitoring/"
  prefix  = var.prefix
  env     = var.env
  rg_name = azurerm_resource_group.monitoring_rg.name
  loc     = var.loc
}