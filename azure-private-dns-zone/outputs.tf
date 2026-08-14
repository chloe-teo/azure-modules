output "private_dns_zone_id" {
  description = "The ID of the private DNS zone."
  value       = azurerm_private_dns_zone.this.id
}

output "private_dns_zone_name" {
  description = "The name of the private DNS zone."
  value       = azurerm_private_dns_zone.this.name
}
