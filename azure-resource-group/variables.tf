variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  validation {
    condition     = trimspace(var.resource_group_name) != ""
    error_message = "resource_group_name must not be empty."
  }
}

variable "location" {
  description = "The location of the Azure resource group"
  type        = string
  validation {
    condition     = trimspace(var.location) != ""
    error_message = "location must not be empty."
  }
}
