variable "azure_function_app_name" {
  description = "The name of the Azure Function App"
  type        = string
}

variable "azure_service_plan_name" {
  description = "The name of the Azure Service Plan"
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the Azure Service Plan"
  type        = string
}

variable "os_type" {
  description = "The OS type of the Azure Service Plan"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "identity_type" {
  description = "The type of identity to use for the Azure Function App"
  type        = string
  default     = "SystemAssigned"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "maximum_instance_count" {
  description = "The maximum number of instances for the Azure Function App"
  type        = number
  default     = 3
}

variable "instance_memory_in_mb" {
  description = "The amount of memory in MB for each instance of the Azure Function App"
  type        = number
  default     = 512
}

variable "runtime_name" {
  description = "The runtime name of the Azure Function App"
  type        = string
  default     = "dotnet-isolated"
}

variable "runtime_version" {
  description = "The runtime version of the Azure Function App"
  type        = string
}

variable "storage_accounts" {
  description = "A map of storage accounts to create"
  type = map(object({
    name                     = string
    account_kind             = string
    account_replication_type = string
    containers = map(object({
      name        = string
      access_type = string
    }))
  }))
}

variable "storage_container_type" {
  description = "The type of storage container to use for the Azure Function App"
  type        = string
  default     = "blobContainer"
}

variable "storage_auth_type" {
  description = "The type of storage authentication to use for the Azure Function App"
  type        = string
  default     = "SystemAssignedIdentity"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}
