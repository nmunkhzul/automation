output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.la_workspace.name
}
output "recovery_services_vault_name" {
  value = azurerm_recovery_services_vault.vault.name
}
output "storage_account" {
  value = azurerm_storage_account.storage_account
}
