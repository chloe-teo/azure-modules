variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must be 3-24 lowercase letters or numbers."
  }
}

variable "account_kind" {
  description = "The kind of storage account"
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  description = "The storage account tier"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be Standard or Premium."
  }
}

variable "account_replication_type" {
  description = "The replication type"
  type        = string
  default     = "LRS"
}

variable "access_tier" {
  description = "The access tier"
  type        = string
  default     = "Hot"
  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "access_tier must be Hot or Cool."
  }
}

variable "containers" {
  description = "A map of containers to create"
  type = map(object({
    name        = string
    access_type = string
  }))
  default = {}
}

variable "queues" {
  description = "A map of storage queues to create."
  type = map(object({
    name = string
  }))
  default = {}
}

variable "tables" {
  description = "A map of storage tables to create."
  type = map(object({
    name = string
  }))
  default = {}
}

variable "shares" {
  description = "A map of Azure File shares to create."
  type = map(object({
    name       = string
    quota      = optional(number, 1)
    access_tier = optional(string, "TransactionOptimized")
  }))
  default = {}
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the storage account"
  type        = bool
  default     = true
}

variable "network_rules" {
  description = "Optional firewall rules for allowing selected public networks"
  type = object({
    default_action             = optional(string, "Allow")
    bypass                     = optional(list(string), ["AzureServices"])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = null
  validation {
    condition     = var.network_rules == null || contains(["Allow", "Deny"], var.network_rules.default_action)
    error_message = "network_rules.default_action must be Allow or Deny."
  }
}

variable "private_endpoint_subnet_id" {
  description = "The subnet ID used for the storage private endpoint. Leave null to disable private endpoints."
  type        = string
  default     = null
}

variable "private_endpoints" {
  description = "Map of storage private endpoints to create. This expects shared DNS zone IDs already owned by the network team."
  type = map(object({
    name                 = string
    subresource_name     = string
    private_dns_zone_ids = optional(list(string), [])
  }))
  default = {}
  validation {
    condition     = length(var.private_endpoints) == 0 || var.private_endpoint_subnet_id != null
    error_message = "private_endpoint_subnet_id must be set when private_endpoints is non-empty."
  }
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
