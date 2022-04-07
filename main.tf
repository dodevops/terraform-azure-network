resource "azurerm_virtual_network" "virtual-network" {
  address_space       = [var.network_cidr]
  location            = var.location
  name                = "${lower(var.project)}${lower(var.stage)}netvnetwork"
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  address_prefixes                               = each.value.cidr
  name                                           = each.key
  resource_group_name                            = var.resource_group
  virtual_network_name                           = azurerm_virtual_network.virtual-network.name
  service_endpoints                              = each.value.service_endpoints
  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies
}
