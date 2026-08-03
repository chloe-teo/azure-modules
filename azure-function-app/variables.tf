variable "application_insights_key" {
  description = "The Application Insights key for the Azure Function App"
  type        = string
}

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

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_account_kind" {
  description = "The kind of storage account"
  type        = string
  default     = "StorageV2"
}

variable "storage_account_tier" {
  description = "The storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "The replication type of the storage account"
  type        = string
  default     = "LRS"
}

variable "storage_account_access_tier" {
  description = "The access tier of the storage account"
  type        = string
  default     = "Hot"
}

variable "containers" {
  description = "A map of containers to create in the storage account"
  type = map(object({
    name        = string
    access_type = string
  }))
  default = {}
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
