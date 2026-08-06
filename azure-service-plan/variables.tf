variable "azure_service_plan_name"{
    description = "The name of the Azure Service Plan"
    type = string
    validation {
      condition     = trimspace(var.azure_service_plan_name) != ""
      error_message = "azure_service_plan_name must not be empty."
    }
}

variable "resource_group_name"{
    description = "The resource group name"
    type = string
    validation {
      condition     = trimspace(var.resource_group_name) != ""
      error_message = "resource_group_name must not be empty."
    }
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  validation {
    condition     = trimspace(var.location) != ""
    error_message = "location must not be empty."
  }
}

variable "os_type" {
  description = "The OS type of the Azure Service Plan"
  type        = string
  default     = "Linux"
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be Linux or Windows."
  }
}

variable "sku_name" {
  description = "The SKU name of the Azure Service Plan"
  type        = string
  default     = "FC1"
  validation {
    condition     = trimspace(var.sku_name) != ""
    error_message = "sku_name must not be empty."
  }
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}