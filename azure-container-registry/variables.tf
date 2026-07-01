
variable "azure_container_registry_name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name"{
    description = "The resource group name"
    type = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"
}