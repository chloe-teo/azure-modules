variable "private_dns_zone_name" {
  description = "The private DNS zone name, for example privatelink.blob.core.windows.net."
  type        = string

  validation {
    condition     = trimspace(var.private_dns_zone_name) != ""
    error_message = "private_dns_zone_name must not be empty."
  }
}

variable "virtual_network_link_name" {
  description = "The name of the private DNS zone virtual network link."
  type        = string

  validation {
    condition     = trimspace(var.virtual_network_link_name) != ""
    error_message = "virtual_network_link_name must not be empty."
  }
}

variable "resource_group_name" {
  description = "The resource group containing the private DNS zone."
  type        = string

  validation {
    condition     = trimspace(var.resource_group_name) != ""
    error_message = "resource_group_name must not be empty."
  }
}

variable "virtual_network_id" {
  description = "The ID of the VNet linked to the private DNS zone."
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft.Network/virtualNetworks/[^/]+$", var.virtual_network_id))
    error_message = "virtual_network_id must be a valid Azure virtual network resource ID."
  }
}

variable "registration_enabled" {
  description = "Whether auto-registration of virtual machine records is enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags assigned to the private DNS zone and link."
  type        = map(string)
  default     = {}
}
