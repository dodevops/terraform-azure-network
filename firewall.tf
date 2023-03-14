resource "azurerm_subnet_network_security_group_association" "nsgassociation-subnet" {
  for_each = {for subnet, value in var.subnets: subnet => value if length(value.rules) > 0}

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.network-security-group-subnet[each.key].id
}

resource "azurerm_network_security_group" "network-security-group-subnet" {
  for_each = {for subnet, value in var.subnets: subnet => value if length(value.rules) > 0}

  location            = var.location
  name                = "${lower(var.project)}${lower(var.stage)}netsg${each.key}"
  resource_group_name = var.resource_group
}

locals {
  subnet_rules = flatten([
    for subnet_key, subnet in var.subnets : [
      for rule_key, rule in subnet.rules : {
        subnet_key                   = subnet_key
        rule_key                     = rule_key
        priority                     = rule.priority
        source_address_prefixes      = rule.source_address_prefixes
        source_port_ranges           = rule.source_port_ranges
        destination_address_prefixes = rule.destination_address_prefixes
        destination_port_ranges      = rule.destination_port_ranges
        protocol                     = rule.protocol
      }
    ]
  ])
}

resource "azurerm_network_security_rule" "network-security-rules-inbound" {
  for_each = {
    for rule in local.subnet_rules : "${rule.subnet_key}.${rule.rule_key}" => rule
  }

  access                       = "Allow"
  direction                    = "Inbound"
  name                         = each.value.rule_key
  network_security_group_name  = "${lower(var.project)}${lower(var.stage)}netsg${each.value.subnet_key}"
  resource_group_name          = var.resource_group
  priority                     = each.value.priority
  protocol                     = each.value.protocol
  source_address_prefixes      = each.value.source_address_prefixes
  source_port_ranges           = each.value.source_port_ranges
  destination_address_prefixes = each.value.destination_address_prefixes
  destination_port_ranges      = each.value.destination_port_ranges
}
