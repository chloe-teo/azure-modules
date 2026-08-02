module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_service_plan" "this" {
  name                = var.azure_service_plan_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  sku_name = var.sku_name
  os_type  = var.os_type
  tags = var.tags
}
