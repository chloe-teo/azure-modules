output "id" {
  description = "The Key Vault resource ID."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "The Key Vault name."
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "The Key Vault URI."
  value       = azurerm_key_vault.this.vault_uri
}