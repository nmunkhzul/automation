resource "azurerm_postgresql_server" "postgresql" {
  name                = var.dbserver["name"]
  location            = var.location
  resource_group_name = var.rg

  administrator_login          = var.dbserver["admin_user"]
  administrator_login_password = var.dbserver["admin_pass"]

  sku_name   = var.dbserver["sku"]
  version    = var.dbserver["version"]
  storage_mb = var.dbserver["storage_mb"]

  backup_retention_days        = var.dbserver["retention_days"]
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  tags                             = var.common_tags
}

resource "azurerm_postgresql_database" "postgre_db" {
  name                = var.dbname
  resource_group_name = var.rg
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
  depends_on          = [azurerm_postgresql_server.postgresql]
}
