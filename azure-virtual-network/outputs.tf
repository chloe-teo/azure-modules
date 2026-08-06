output "id" {
  description = "The ID of the Azure virtual network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value = {
    for subnet in azurerm_subnet.this : subnet.name => subnet.id
  }
}