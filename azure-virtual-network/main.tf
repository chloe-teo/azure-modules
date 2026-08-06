module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = var.azure_virtual_network_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = var.azure_virtual_network_address_space
  tags                = var.tags

}

resource "azurerm_subnet" "this" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
  }

  name                 = each.value.name
  resource_group_name  = module.resource_group.name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes     = each.value.address_prefixes

}

resource "azurerm_network_security_group" "this" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
  }

  name                = "nsg-${each.value.name}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
  }
  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}


