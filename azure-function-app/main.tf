locals {
  func_storage_container = one(values(module.storage_account.storage_containers))
}

module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "service_plan" {
  source = "../azure-service-plan"

  resource_group_name     = var.resource_group_name
  location                = var.location
  azure_service_plan_name = var.azure_service_plan_name
  sku_name                = var.sku_name
  os_type                 = var.os_type
  tags                    = var.tags
}

module "storage_account" {
  source = "../azure-storage-account"

  resource_group_name      = var.resource_group_name
  location                 = var.location
  storage_account_name     = var.storage_account_name
  account_kind             = var.storage_account_kind
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  access_tier              = var.storage_account_access_tier
  containers               = var.containers
  tags                     = var.tags
}

resource "azurerm_function_app_flex_consumption" "flex_app" {
  name                = var.azure_function_app_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  service_plan_id     = module.service_plan.id

  storage_container_type        = var.storage_container_type
  storage_container_endpoint    = "${module.storage_account.primary_blob_endpoint}${local.func_storage_container.name}"
  storage_authentication_type   = var.storage_auth_type
  runtime_name                  = var.runtime_name
  runtime_version               = var.runtime_version
  maximum_instance_count        = var.maximum_instance_count
  instance_memory_in_mb         = var.instance_memory_in_mb
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.virtual_network_subnet_id

  site_config {
    application_insights_key = var.application_insights_key

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        name                      = ip_restriction.value.name
        action                    = ip_restriction.value.action
        ip_address                = try(ip_restriction.value.ip_address, null)
        priority                  = ip_restriction.value.priority
        virtual_network_subnet_id = try(ip_restriction.value.virtual_network_subnet_id, null)
      }
    }
  }

  identity {
    type = var.identity_type
  }

  tags = var.tags

  depends_on = [
    module.service_plan,
    module.storage_account
  ]
}
