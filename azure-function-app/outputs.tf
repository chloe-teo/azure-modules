output "id" {
  description = "The ID of the azure function app"
  value       = azurerm_function_app_flex_consumption.flex-app.id
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = module.storage_account.storage_account_id
}

output "identity_principal_id"{
    description = "The identity of the azure function app"
    value       = azurerm_function_app_flex_consumption.flex-app.identity[0].principal_id
}