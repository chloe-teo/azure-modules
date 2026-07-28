module "resource_group" {
  source = "../azure-resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name           = var.system_node_pool_name
    node_count     = var.system_node_pool_node_count
    vm_size        = var.system_node_pool_vm_size
    vnet_subnet_id = var.system_subnet_id
    only_critical_addons_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "cilium"
    network_data_plane = "cilium"
    network_plugin_mode = "overlay"
    load_balancer_sku = "basic"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  # azure_active_directory_role_based_access_control{
  #   azure_rbac_enabled = true
  #   admin_group_object_ids = var.admin_group_object_ids
  # }

  tags = var.tags

  depends_on = [module.resource_group]
}

resource "azurerm_kubernetes_cluster_node_pool" "application" {
  name                  = var.application_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.application_node_pool_vm_size
  node_count            = var.application_node_pool_node_count
  mode                  = "User"
  pod_subnet_id         = var.apps_subnet_id

  depends_on = [azurerm_kubernetes_cluster.this]
}
