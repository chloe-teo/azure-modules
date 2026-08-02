variable "azure_service_plan_name"{
    description = "The name of the Azure Service Plan"
    type = string
}

variable "resource_group_name"{
    description = "The resource group name"
    type = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "os_type" {
  description = "The OS type of the Azure Service Plan"
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "The SKU name of the Azure Service Plan"
  type        = string
  default     = "FC1"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}