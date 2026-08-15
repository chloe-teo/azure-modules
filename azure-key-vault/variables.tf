variable "resource_group_name" {
  description = "The resource group name."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
}

variable "key_vault_name" {
  description = "The globally unique Key Vault name."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{3,24}$", var.key_vault_name))
    error_message = "key_vault_name must be 3-24 characters containing only letters, numbers, and hyphens."
  }
}

variable "sku_name" {
  description = "The Key Vault SKU."
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "sku_name must be standard or premium."
  }
}

variable "role_assignments" {
  description = "Role assignments to create on the Key Vault, keyed by assignment name."
  type = map(object({
    principal_id         = string
    role_definition_name = string
  }))
  default = {}
  validation {
    condition = alltrue([
      for assignment in var.role_assignments : trimspace(assignment.principal_id) != "" && trimspace(assignment.role_definition_name) != ""
    ])
    error_message = "Each role assignment must specify a principal_id and role_definition_name."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed when no private endpoint is configured."
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "The subnet ID for the Key Vault private endpoint."
  type        = string
  default     = null
}

variable "private_dns_zone_ids" {
  description = "Shared private DNS zone IDs for the Key Vault private endpoint."
  type        = list(string)
  default     = []
}

variable "network_acls" {
  description = "Optional Key Vault network ACLs."
  type = object({
    bypass                     = optional(string, "AzureServices")
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = null
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "The number of days deleted items are retained."
  type        = number
  default     = 90
}

variable "tags" {
  description = "Tags assigned to the Key Vault and private endpoint."
  type        = map(string)
  default     = {}
}