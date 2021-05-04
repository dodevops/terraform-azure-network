resource "azurerm_virtual_network_peering" "network-peering" {
  count                     = var.peering_remote_virtual_network_id == "" ? 0 : 1
  name                      = "${var.project}${var.stage}netpeer"
  remote_virtual_network_id = var.peering_remote_virtual_network_id
  resource_group_name       = var.resource_group
  virtual_network_name      = azurerm_virtual_network.virtual-network.name
}
