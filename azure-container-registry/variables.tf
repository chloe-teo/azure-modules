
variable "azure_container_registry_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{5,50}$", var.azure_container_registry_name))
    error_message = "azure_container_registry_name must be 5-50 lowercase letters or numbers."
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