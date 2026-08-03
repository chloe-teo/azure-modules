module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  access_tier              = var.access_tier
  account_replication_type = var.account_replication_type
  tags                     = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = each.value.access_type
}