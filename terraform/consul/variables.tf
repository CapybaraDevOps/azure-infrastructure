locals {
  cluster_id = "${var.app}-${var.env}-${var.location}"
}

variable "env" {
  description = "The Working environment"
  type        = string
}

variable "app" {
  description = "The application name"
  type        = string
}

variable "region" {
  description = "The default region to deploy infrastructure"
  type        = string
}

variable "location" {
  description = "The location short name"
  type        = string
}

variable "network_region" {
  type        = string
  description = "the network region"
  default     = "West US 2"
}

variable "consul_version" {
  type        = string
  description = "The Consul version"
  default     = "v1.19.1"
}

variable "vnet_cidrs" {
  type        = list(string)
  description = "the CIDR ranges of the vnet. This should make sense with vnet_subnets"
  default     = ["10.0.0.0/16"]
}

variable "vnet_subnets" {
  type        = map(string)
  description = "the subnets associated with the vnet"
  default = {
    "subnet1" = "10.0.1.0/24",
    "subnet2" = "10.0.2.0/24",
    "subnet3" = "10.0.3.0/24",
  }
}

variable "subnet_delegation" {
  type        = map(map(any))
  description = "A map of subnet name to delegation block on the subnet"
  default = {
      subnet1 = {
        "aks-delegation" = {
          service_name = "Microsoft.ContainerService/managedClusters"
          service_actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action"
          ]
        }
      }
    }
}