variable "resource_group_name" {
  description = "The resource group where the private endpoints are created."
  type        = string
}

variable "location" {
  description = "The Azure region for the private endpoints."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID used for the private endpoints."
  type        = string
}

variable "tags" {
  description = "Tags applied to the private endpoints."
  type        = map(string)
  default     = {}
}

variable "private_endpoints" {
  description = "Map of private endpoints to create keyed by endpoint type, such as blob or queue."
  type = map(object({
    name                           = string
    private_connection_resource_id = string
    subresource_name               = string
    private_dns_zone_ids           = optional(list(string), [])
  }))
  default = {}
}
