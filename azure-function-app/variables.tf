variable "application_insights_key" {
  description = "The Application Insights key for the Azure Function App"
  type        = string
}

variable "application_insights_connection_string" {
  description = "The Application Insights connection string for the Azure Function App"
  type        = string
}

variable "azure_function_app_name" {
  description = "The name of the Azure Function App"
  type        = string
  validation {
    condition     = trimspace(var.azure_function_app_name) != ""
    error_message = "azure_function_app_name must not be empty."
  }
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
  validation {
    condition     = var.maximum_instance_count >= 1 && var.maximum_instance_count <= 1000
    error_message = "maximum_instance_count must be between 1 and 1000."
  }
}

variable "instance_memory_in_mb" {
  description = "The amount of memory in MB for each instance of the Azure Function App"
  type        = number
  default     = 512
  validation {
    condition     = var.instance_memory_in_mb > 0
    error_message = "instance_memory_in_mb must be greater than zero."
  }
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
  validation {
    condition     = var.storage_container_type == "blobContainer"
    error_message = "storage_container_type must be blobContainer."
  }
}

variable "storage_auth_type" {
  description = "The type of storage authentication to use for the Azure Function App"
  type        = string
  default     = "SystemAssignedIdentity"
  validation {
    condition     = contains(["SystemAssignedIdentity", "UserAssignedIdentity", "StorageAccountConnectionString"], var.storage_auth_type)
    error_message = "storage_auth_type must be a supported Azure Functions storage authentication type."
  }
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for the Azure Function App"
  type        = bool
  default     = true
}

variable "https_only" {
  description = "Should the Azure Function App require HTTPS-only access"
  type        = bool
  default     = true
}

variable "virtual_network_subnet_id" {
  description = "The delegated subnet ID used for Function App VNet integration"
  type        = string
  default     = null
}

variable "storage_private_endpoint_subnet_id" {
  description = "The subnet ID for the linked storage account private endpoint"
  type        = string
  default     = null
}

variable "storage_private_dns_zone_ids" {
  description = "Private DNS zone IDs associated with the storage private endpoint"
  type        = list(string)
  default     = []
}

variable "ip_restrictions" {
  description = "A list of IP restriction rules for the Azure Function App"
  type = list(object({
    name                      = string
    action                    = string
    ip_address                = optional(string)
    virtual_network_subnet_id = optional(string)
    priority                  = number
  }))
  default = []
}

variable "ip_restriction_default_action" {
  description = "The default action for IP restrictions"
  type        = string
  default     = "Deny"
  validation {
    condition     = contains(["Allow", "Deny"], var.ip_restriction_default_action)
    error_message = "ip_restriction_default_action must be either 'Allow' or 'Deny'."
  }
}

variable "scm_ip_restriction_default_action" {
  description = "The default action for SCM IP restrictions"
  type        = string
  default     = "Deny"
  validation {
    condition     = contains(["Allow", "Deny"], var.scm_ip_restriction_default_action)
    error_message = "scm_ip_restriction_default_action must be either 'Allow' or 'Deny'."
  }
}
