output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "storage_containers" {
  description = "Map of created containers"
  value = {
    for key, container in azurerm_storage_container.this : key => {
      name = container.name
      id   = container.id
    }
  }
}

output "storage_shares" {
  description = "Map of created Azure file shares"
  value = {
    for key, share in azurerm_storage_share.this : key => {
      name = share.name
      id   = share.id
    }
  }
}

output "private_endpoint_ids" {
  description = "IDs of the created storage private endpoints keyed by endpoint type."
  value       = module.private_endpoint.private_endpoint_ids
}

output "private_endpoint_names" {
  description = "Names of the created storage private endpoints keyed by endpoint type."
  value       = module.private_endpoint.private_endpoint_names
}