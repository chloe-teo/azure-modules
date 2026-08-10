
variable "azure_virtual_network_name" {
  description = "The name of the Azure Virtual Network"
  type        = string
  validation {
    condition     = trimspace(var.azure_virtual_network_name) != ""
    error_message = "azure_virtual_network_name must not be empty."
  }
}

variable "azure_virtual_network_address_space" {
  description = "The address space of the Azure virtual network"
  type        = list(string)
  validation {
    condition     = length(var.azure_virtual_network_address_space) > 0
    error_message = "azure_virtual_network_address_space must contain at least one CIDR block."
  }
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    delegation_name  = optional(string)
  }))
  validation {
    condition     = length(var.subnets) > 0 && alltrue([for subnet in values(var.subnets) : trimspace(subnet.name) != "" && length(subnet.address_prefixes) > 0])
    error_message = "subnets must contain named subnets with at least one address prefix."
  }
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}
