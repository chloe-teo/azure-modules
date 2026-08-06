output "private_dns_zone_id" {
  description = "The ID of the private DNS zone."
  value       = azurerm_private_dns_zone.this.id
}

output "private_dns_zone_name" {
  description = "The name of the private DNS zone."
  value       = azurerm_private_dns_zone.this.name
}

output "virtual_network_link_id" {
  description = "The ID of the private DNS zone virtual network link."
  value       = azurerm_private_dns_zone_virtual_network_link.this.id
}
