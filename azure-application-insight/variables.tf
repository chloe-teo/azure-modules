variable "apps_insights_name"{
  description = "The name of the Azure Application Insights"
  type        = string
}

variable "application_type" {
  description = "The application type of the Azure Application Insights"
  type        = string
  default     = "web"
}

variable "resource_group_name"{
    description = "The resource group name"
    type = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}