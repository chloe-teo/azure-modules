
variable "azure_virtual_network_name" {
  description = "The name of the Azure Virtual Network"
  type        = string
}

variable "azure_virtual_network_address_space" {
  description = "The address space of the Azure virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
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
