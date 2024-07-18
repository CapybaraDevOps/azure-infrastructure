data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "${local.cluster_id}-gid"
  location = var.network_region
}

resource "azurerm_route_table" "rt" {
  name                = "${local.cluster_id}-rt"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${local.cluster_id}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "network" {
  source              = "Azure/vnet/azurerm"
  version             = "~> 2.6.0"
  address_space       = var.vnet_cidrs
  resource_group_name = azurerm_resource_group.rg.name
  subnet_delegation   = var.subnet_delegation
  subnet_names        = keys(var.vnet_subnets)
  subnet_prefixes     = values(var.vnet_subnets)
  vnet_name           = "${local.cluster_id}-vnet"
  vnet_location       = var.network_region

  route_tables_ids = { for i, subnet in keys(var.vnet_subnets) : subnet => azurerm_route_table.rt.id }

  nsg_ids = { for i, subnet in keys(var.vnet_subnets) : subnet => azurerm_network_security_group.nsg.id }

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_network_security_rule" "ingress" {
  name                        = "consul-service-ingress"
  priority                    = 301
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443", "8080", "8300", "8301", "8302", "8500", "8600", "80", "9301"]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "consul-ingress-udp" {
  name                        = "consul-ingress-udp"
  priority                    = 302
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_ranges     = ["8301", "8302", "8600", "9301"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ingress-outbound" {
  name                        = "consul-service-ingress-outbound"
  priority                    = 301
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["443", "8080", "8300", "8301", "8302", "8500", "8600", "80", "9301"]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "consul-ingress-udp--outbound" {
  name                        = "consul-ingress-udp-outbound"
  priority                    = 302
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_ranges     = ["8301", "8302", "8600", "9301"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}