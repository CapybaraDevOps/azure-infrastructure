resource "datadog_integration_azure" "sandbox" {
  tenant_name   = data.azurerm_client_config.current.tenant_id
  client_id     = data.azurerm_client_config.current.client_id
  client_secret = data.azurerm_key_vault_secret.client_secret.value
}