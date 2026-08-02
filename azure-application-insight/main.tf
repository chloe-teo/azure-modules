module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_application_insights" "this" {
  name                = var.apps_insights_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  application_type    = var.application_type

  tags = var.tags
}

