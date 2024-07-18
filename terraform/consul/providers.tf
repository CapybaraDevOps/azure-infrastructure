terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 3.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.3.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.3"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2"
    }
  }

  required_version = ">= 1.0.11"

  provider_meta "hcp" {
    module_name = "hcp-consul"
  }
}

provider "helm" {
  kubernetes {
    client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
    host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
    password               = azurerm_kubernetes_cluster.k8s.kube_config.0.password
    username               = azurerm_kubernetes_cluster.k8s.kube_config.0.username
  }
}

provider "kubernetes" {
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
  host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
  password               = azurerm_kubernetes_cluster.k8s.kube_config.0.password
  username               = azurerm_kubernetes_cluster.k8s.kube_config.0.username
}

provider "kubectl" {
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
  host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
  load_config_file       = false
  password               = azurerm_kubernetes_cluster.k8s.kube_config.0.password
  username               = azurerm_kubernetes_cluster.k8s.kube_config.0.username
}

provider "azurerm" {
  features {}
  subscription_id = "cb933e29-302b-4208-bf2c-647df002075a"
  tenant_id       = "8e5a9f9f-3b52-4f94-894c-439f1683c211"
}