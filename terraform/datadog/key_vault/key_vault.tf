data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "key_vault" {
  name     = "key-vault-datadog"
  location = var.region
}

resource "azurerm_key_vault" "datadog_key_vault" {
  name                       = "keyvault-datadog-capybar"
  location                   = azurerm_resource_group.key_vault.location
  resource_group_name        = azurerm_resource_group.key_vault.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 20

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "datadog_api_key" {
  name         = "datadog-api-key"
  value        = local.secrets.api_key
  key_vault_id = azurerm_key_vault.datadog_key_vault.id
}

resource "azurerm_key_vault_secret" "datadog_app_key" {
  name         = "datadog-app-key"
  value        = local.secrets.app_key
  key_vault_id = azurerm_key_vault.datadog_key_vault.id
}

resource "azurerm_key_vault_secret" "client_secret" {
  name         = "client-secret"
  value        = local.secrets.client_secret
  key_vault_id = azurerm_key_vault.datadog_key_vault.id
}

resource "azurerm_key_vault_secret" "client_secret" {
  name         = "client-id"
  value        = local.secrets.client_id
  key_vault_id = azurerm_key_vault.datadog_key_vault.id
}

resource "azurerm_key_vault_secret" "access_key" {
  name         = "access-key"
  value        = local.secrets.client_id
  key_vault_id = azurerm_key_vault.datadog_key_vault.id
}

resource "azurerm_key_vault_secret" "secret_key" {
  name         = "secret-key"
  value        = local.secrets.client_id
  key_vault_id = azurerm_key_vault.datadog_key_vault.id
}