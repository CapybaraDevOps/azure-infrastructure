data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "datadog_key_vault" {
  name     = "keyvault-datadog-capybar"
  resource_group_name = "key-vault-datadog"
}

data "azurerm_key_vault_secret" "datadog_api_key" {
  name         = "datadog-api-key"
  key_vault_id = data.azurerm_key_vault.datadog_key_vault.id
}

data "azurerm_key_vault_secret" "datadog_app_key" {
  name         = "datadog-app-key"
  key_vault_id = data.azurerm_key_vault.datadog_key_vault.id
}

data "azurerm_key_vault_secret" "client_secret" {
  name         = "client-secret"
  key_vault_id = data.azurerm_key_vault.datadog_key_vault.id
}