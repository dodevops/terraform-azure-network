# Sets up inbound security rules for the cluster

resource "azurerm_network_security_group" "network-security-group" {
  location            = var.location
  name                = "${lower(var.project)}${lower(var.stage)}netsg"
  resource_group_name = var.resource_group
}

locals {
  subnet_id = replace(
    replace(lower(azurerm_subnet.default-subnet.id), "microsoft.network/virtualnetworks", "Microsoft.Network/virtualNetworks"),
    "resourcegroups",
    "resourceGroups"
  )
}

resource "azurerm_subnet_network_security_group_association" "network-security-group-association" {
  network_security_group_id = azurerm_network_security_group.network-security-group.id
  subnet_id                 = local.subnet_id
}

resource "azurerm_network_security_rule" "network-security-rules-inbound" {
  for_each = var.rules

  access                       = "Allow"
  direction                    = "Inbound"
  name                         = each.key
  network_security_group_name  = azurerm_network_security_group.network-security-group.name
  resource_group_name          = var.resource_group
  priority                     = each.value.priority
  protocol                     = each.value.protocol
  source_address_prefixes      = each.value.source_address_prefixes
  source_port_ranges           = each.value.source_port_ranges
  destination_address_prefixes = each.value.destination_address_prefixes
  destination_port_ranges      = each.value.destination_port_ranges
}
