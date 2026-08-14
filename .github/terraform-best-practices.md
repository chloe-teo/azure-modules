# Terraform Best Practices and Module Structure

Follow these rules for all Terraform work in this repository.

## 1. Terraform Module Structure (Mandatory)
- When creating a new Terraform module directory, first inspect at least one neighboring module under `azure-modules` and follow its established structure and naming conventions.
- Every reusable module must include `main.tf`, `variables.tf`, and `providers.tf`.
- Add `outputs.tf` whenever the module exposes resource IDs, names, endpoints, or other values needed by callers. Keep outputs documented and avoid exposing unnecessary sensitive values.
- Keep provider requirements in the module's `providers.tf` and align the provider source and version constraint with the consuming configuration.
- Do not treat generated `.terraform` directories, lock files, state files, plans, or cached module copies as module source structure.
- Before finishing a new module, run `terraform fmt` and `terraform validate` in the module directory, then verify that the caller supplies required inputs and consumes any required outputs.

## 2. Terraform Best Practices
- Never hard-code credentials, tokens, access keys, subscription secrets, or other sensitive values. Use variables, environment variables, managed identities, or a secret manager, and mark sensitive variables and outputs with `sensitive = true` when appropriate.
- Protect remote state with an authenticated backend, encryption, access controls, and locking. Never commit `.tfstate`, `.tfplan`, generated backend files, or provider cache directories unless explicitly required.
- Run `terraform plan` and review the proposed changes before `terraform apply`; never apply changes automatically unless the user explicitly requests it.
- Prefer data sources and explicit resource dependencies over hard-coded IDs or fragile ordering assumptions. Avoid broad `depends_on` declarations when normal references already establish the dependency.
- Use stable, descriptive resource names and consistent tags. Avoid changing names or resource addresses unnecessarily because they can force replacement.
- Validate variable constraints, provide descriptions and safe defaults, and use preconditions or postconditions for important Azure requirements such as subnet delegation, compatible regions, and allowed SKU values.
- For networking changes, verify both control-plane configuration and data-plane reachability, including private DNS, routing, firewall rules, identity permissions, and required subnet delegation.
- Keep documentation and examples current when adding module inputs, outputs, networking behavior, or breaking changes.
