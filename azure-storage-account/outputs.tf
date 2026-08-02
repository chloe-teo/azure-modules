output "storage_accounts" {
  value = {
    for name, account in azurerm_storage_account.this : name => {
      id                   = account.id
      primary_blob_endpoint = account.primary_blob_endpoint
    }
  }
}

output "storage_containers" {
  value = {
    for key, container in azurerm_storage_container.this : key => {
      name = container.name
      id   = container.id
    }
  }
}