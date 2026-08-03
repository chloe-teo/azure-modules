variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "storage_accounts" {
  description = "A map of storage accounts to create"
  type = map(object({
    name                     = string
    account_kind             = string
    account_replication_type = string
    access_tier              = string
    containers = map(object({
      name        = string
      access_type = string
    }))
  }))
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}
