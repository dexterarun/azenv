resource "azurerm_storage_account" "sg_acct" {
  // name must be globally unique
  name                     = "${var.prefix}${var.env}${var.loc.short}${var.sg_name_suffix}"
  
  resource_group_name      = var.rg_name
  location                 = var.loc.long
  
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  tags = {
    environment = var.env
  }
}