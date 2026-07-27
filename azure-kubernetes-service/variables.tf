variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region for the cluster"
  type        = string
}

variable "system_node_pool_name" {
  description = "Name of the system node pool"
  type        = string
  default     = "system"
}

variable "system_node_pool_node_count" {
  description = "Node count for the system node pool"
  type        = number
  default     = 1
}

variable "system_node_pool_vm_size" {
  description = "VM size for the system node pool"
  type        = string
  default     = "Standard_B2s"
}

variable "application_node_pool_name" {
  description = "Name of the application node pool"
  type        = string
  default     = "application"
}

variable "application_node_pool_node_count" {
  description = "Node count for the application node pool"
  type        = number
  default     = 1
}

variable "application_node_pool_vm_size" {
  description = "VM size for the application node pool"
  type        = string
  default     = "Standard_B2s"
}

variable "tags" {
  description = "Tags to assign to the cluster"
  type        = map(string)
  default     = {}
}

variable "vnet_id" {
  description = "The ID of the virtual network to attach to the AKS cluster"
  type        = string
  default     = null
}

variable "system_subnet_id" {
  description = "The ID of the subnet to use for the AKS node pools - system"
  type        = string
  default     = null
}

variable "apps_subnet_id" {
  description = "The ID of the subnet to use for the AKS node pools - applications"
  type        = string
  default     = null
}

variable "service_cidr" {
  description = "The CIDR block for the Kubernetes service network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "The IP address within the Kubernetes service CIDR to use for the DNS service"
  type        = string
  default     = "10.0.0.10"
}

variable kubernetes_version {
  description = "The version of Kubernetes to use for the AKS cluster"
  type        = string
  default     = null
}

variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs to be granted admin access to the AKS cluster"
  type        = list(string)
  default     = []
}