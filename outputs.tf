output "gateway_subnet_id" {
  description = "The id of the gateway subnet"
  value       = var.gateway_subnet_cidr == "NONE" ? 0 : azurerm_subnet.gateway-subnet[0].id
}
output "default_subnet_id" {
  description = "The id of the default subnet"
  value       = azurerm_subnet.default-subnet.id
}

output "network_id" {
  description = "The id of the virtual network"
  value       = azurerm_virtual_network.virtual-network.id
}

output "network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.virtual-network.name
}
