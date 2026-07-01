module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.azure_container_registry_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = "Standard"
  admin_enabled       = false
}