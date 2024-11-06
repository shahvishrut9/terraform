resource "azurerm_postgresql_server" "postgresql_server" {
  name                    = var.db_server_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.db_sku_name
  version                 = var.db_version
  administrator_login     = var.admin_username
  administrator_login_password = var.admin_password
  ssl_enforcement_enabled = true
  tags     = local.common_tags
}

