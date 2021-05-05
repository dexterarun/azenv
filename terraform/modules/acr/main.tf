resource "azurerm_container_registry" "acr" {
  // only alpha numeric characters allowed
  name                = "${var.prefix}${var.env}${var.loc.short}${var.name_suffix}"
  location            = var.loc.long
  resource_group_name = var.rg_name
  sku                 = "Basic"
  admin_enabled       = false
}