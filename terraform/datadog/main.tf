terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "azurerm" {
  features {}
}

# Configure the Datadog provider
provider "datadog" {
  api_url = var.datadog_api_url
  api_key = data.azurerm_key_vault_secret.datadog_api_key.value
  app_key = data.azurerm_key_vault_secret.datadog_app_key.value
}

provider "aws" {
  region = "us-east-1"
  access_key = data.azurerm_key_vault_secret.access_key.value
  secret_key = data.azurerm_key_vault_secret.secret_key.value
}