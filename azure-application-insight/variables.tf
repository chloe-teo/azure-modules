variable "apps_insights_name" {
  description = "The name of the Azure Application Insights"
  type        = string
  validation {
    condition     = trimspace(var.apps_insights_name) != ""
    error_message = "apps_insights_name must not be empty."
  }
}

variable "application_type" {
  description = "The application type of the Azure Application Insights"
  type        = string
  default     = "web"
  validation {
    condition     = contains(["web", "other"], var.application_type)
    error_message = "application_type must be web or other."
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