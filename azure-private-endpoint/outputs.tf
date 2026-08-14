output "private_endpoint_ids" {
  description = "IDs of the created private endpoints keyed by their endpoint type."
  value       = { for k, v in azurerm_private_endpoint.this : k => v.id }
}

output "private_endpoint_names" {
  description = "Names of the created private endpoints keyed by their endpoint type."
  value       = { for k, v in azurerm_private_endpoint.this : k => v.name }
}
