data "azurerm_client_config" "current" {}

module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_key_vault" "this" {
  name                          = var.key_vault_name
  location                      = module.resource_group.location
  resource_group_name           = module.resource_group.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = var.sku_name
  rbac_authorization_enabled    = true
  purge_protection_enabled      = var.purge_protection_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : [var.network_acls]
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }
}

module "role_assignment" {
  source = "../azure-role-assignment"

  for_each = var.role_assignments

  scope                = azurerm_key_vault.this.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}

module "private_endpoint" {
  source = "../azure-private-endpoint"

  resource_group_name            = module.resource_group.name
  location                       = module.resource_group.location
  subnet_id                      = var.private_endpoint_subnet_id
  private_connection_resource_id = azurerm_key_vault.this.id
  tags                           = var.tags

  private_endpoints = var.private_endpoint_subnet_id == null ? {} : {
    vault = {
      name                 = "pe-${var.key_vault_name}"
      subresource_name     = "vault"
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }
}