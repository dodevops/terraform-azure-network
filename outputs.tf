output "network" {
  description = "The created network resource"
  value       = azurerm_virtual_network.virtual-network
}

output "subnet_ids" {
  description = "Map of the created subnet ids"
  value       = { for p in sort(keys(var.subnets)) : p => azurerm_subnet.subnet[p].id }
}