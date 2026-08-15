locals {
  private_endpoints = {
    for key, endpoint in var.private_endpoints : key => {
      name                 = endpoint.name
      subresource_name     = endpoint.subresource_name
      private_dns_zone_ids = endpoint.private_dns_zone_ids
    }
    if(
      (endpoint.subresource_name == "blob" && length(var.containers) > 0) ||
      (endpoint.subresource_name == "queue" && length(var.queues) > 0) ||
      (endpoint.subresource_name == "table" && length(var.tables) > 0) ||
      (endpoint.subresource_name == "file" && length(var.shares) > 0)
    )
  }
}

module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_storage_account" "this" {
  name                          = var.storage_account_name
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  account_kind                  = var.account_kind
  account_tier                  = var.account_tier
  access_tier                   = var.access_tier
  account_replication_type      = var.account_replication_type
  public_network_access_enabled = length(var.private_endpoints) == 0 ? var.public_network_access_enabled : false
  tags                          = var.tags

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [var.network_rules]
    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }
}

resource "azurerm_storage_container" "this" {
  for_each = var.containers

  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = each.value.access_type
}

resource "azurerm_storage_queue" "this" {
  for_each = var.queues

  name               = each.value.name
  storage_account_id = azurerm_storage_account.this.id
}

resource "azurerm_storage_table" "this" {
  for_each = var.tables

  name               = each.value.name
  storage_account_id = azurerm_storage_account.this.id
}

resource "azurerm_storage_share" "this" {
  for_each = var.shares

  name               = each.value.name
  storage_account_id = azurerm_storage_account.this.id
  quota              = each.value.quota
  access_tier        = each.value.access_tier
}

module "private_endpoint" {
  source = "../azure-private-endpoint"

  resource_group_name            = module.resource_group.name
  location                       = module.resource_group.location
  subnet_id                      = var.private_endpoint_subnet_id
  private_connection_resource_id = azurerm_storage_account.this.id
  tags                           = var.tags

  private_endpoints = local.private_endpoints
}
