g# Azure Terraform Modules

Reusable Terraform modules for provisioning Azure infrastructure components.

## Modules

| Module | Purpose |
|--------|---------|
| `azure-resource-group` | Create Azure resource groups |
| `azure-virtual-network` | VNet with configurable subnets |
| `azure-kubernetes-service` | AKS cluster deployment |
| `azure-container-registry` | Container image registry |
| `azure-service-plan` | App Service Plan (for Functions, Web Apps) |
| `azure-function-app` | Serverless function deployments |
| `azure-storage-account` | Blob storage, Terraform state backend |
| `azure-application-insight` | Application monitoring & logging |

## Module Structure

Each module includes:
```
module-name/
├── main.tf          # Resource definitions
├── variables.tf     # Input variables
├── outputs.tf       # Output values
└── providers.tf     # Required providers (if module-level config needed)
```

## Usage

Reference modules in Terragrunt configurations:

```hcl
terraform {
  source = "${find_in_parent_folders("azure-modules")}/azure-kubernetes-service"
}

inputs = {
  cluster_name       = "aks-dev-cluster"
  resource_group     = "rg-dev"
  location           = "Sweden Central"
  node_count         = 2
}
```

## Best Practices

- Each module manages a single resource type
- Variables are explicitly defined in `variables.tf`
- Outputs are exported in `outputs.tf` for cross-module dependencies
- Modules are environment-agnostic (values provided via Terragrunt)
