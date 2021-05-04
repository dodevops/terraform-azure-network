resource "azurerm_virtual_network" "virtual-network" {
  address_space       = [var.network_cidr]
  location            = var.location
  name                = "${lower(var.project)}${lower(var.stage)}netvnetwork"
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "default-subnet" {
  address_prefixes     = [var.default_subnet_cidr]
  name                 = "default"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.virtual-network.name
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_subnet" "gateway-subnet" {
  count                = var.gateway_subnet_cidr == "NONE" ? 0 : 1
  name                 = "GatewaySubnet"
  address_prefixes     = [var.gateway_subnet_cidr]
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.virtual-network.name
}
