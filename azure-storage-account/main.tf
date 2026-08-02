locals {
    storage_account_containers = merge([
        for storage_account in var.storage_accounts : {
            for container in storage_account.containers :
            storage_account.name + "_" + container.name => merge(container, {
                storage_account_name = storage_account.name
            })
        }
    ]...)
}

module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_storage_account" "this" {
  for_each = {
    for storage_account in var.storage_accounts : storage_account.name => storage_account
  }

  name                     = each.value.name
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags                     = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each = local.storage_account_containers
  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.this[each.value.storage_account_name].id
  container_access_type = each.value.access_type
}