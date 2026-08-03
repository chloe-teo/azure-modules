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