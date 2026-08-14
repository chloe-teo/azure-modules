variable "private_dns_zone_name" {
  description = "The private DNS zone name, for example privatelink.blob.core.windows.net."
  type        = string

  validation {
    condition     = trimspace(var.private_dns_zone_name) != ""
    error_message = "private_dns_zone_name must not be empty."
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

variable "tags" {
  description = "Tags assigned to the private DNS zone."
  type        = map(string)
  default     = {}
}
