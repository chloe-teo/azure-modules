output "name" {
  description = "The name of the resource group"
  value       = data.azurerm_resource_group.this.name
}

output "location" {
  description = "The location of the resource group"
  value       = data.azurerm_resource_group.this.location
}

output "id" {
  description = "The ID of the resource group"
  value       = data.azurerm_resource_group.this.id
}
