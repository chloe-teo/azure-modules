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
}

variable "containers" {
  description = "A map of containers to create"
  type = map(object({
    name        = string
    access_type = string
  }))
  default = {}
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
