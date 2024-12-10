resource "azurerm_log_analytics_workspace" "la_workspace" {
  name                = var.log_analytics_workspace["law_name"]
  location            = var.location
  resource_group_name = var.rg
  sku                 = var.log_analytics_workspace["log_sku"]
  retention_in_days   = var.log_analytics_workspace["retention"]
  tags                = var.common_tags
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = var.recovery_services_vault["vault_name"]
  location            = var.location
  resource_group_name = var.rg
  sku                 = var.recovery_services_vault["vault_sku"]
  tags                = var.common_tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account["account_name"]
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = var.storage_account["tier"]
  account_replication_type = var.storage_account["replication_type"]
  tags                     = var.common_tags
}
