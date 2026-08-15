# Private Network-First Design and Azure Resource Standards

This document is the repository standard for private-network-first Azure module design. These rules are mandatory for any new Azure module, resource, or networking change.

## Private Network-First Design (Mandatory)
- New Azure modules must be designed with a private-network-first mindset: prefer private connectivity, private endpoints, VNet integration, private DNS, and restricted access before exposing public endpoints.
- Public access must be treated as an explicit opt-in, not the default assumption. If a public endpoint is introduced, document why it is required and keep the access pattern clearly configurable.
- For every new module, consider the networking model up front: required subnets, delegation, private DNS zone links, NSG/ASG rules, firewall rules, and whether the resource should support both public and private connectivity modes.
- When a resource can be configured with private-only access, prefer inputs and outputs that support `private_dns_zone_ids`, `subnet_id`, VNet integration, and private endpoint wiring rather than only public access settings.
- Modules must include secure defaults for network exposure, such as disabling public network access when the service supports it, while preserving an easy path for private consumption and controlled ingress.
- If a module exposes a public endpoint, it should still model private connectivity as the primary path and include clear variables to enable/disable it without breaking private-network scenarios.

## Azure Resource Requirements (Mandatory)
- Before generating or changing Azure Terraform code, identify the exact AzureRM resource type and hosting model in use. Do not infer requirements from similarly named legacy resources.
- Use the Terraform MCP server to confirm the provider version and resource schema for the exact resource type. Do not assume that a newer provider version has the same requirements as an older one.
- Use the Terraform MCP server when creating or updating Azure Terraform code to confirm the correct properties for the exact resource.
- For service-specific requirements such as subnet delegation, delegated service names, supported SKUs, API fields, identity settings, or networking constraints, consult the pinned AzureRM provider documentation or schema before proposing the implementation.
- When a resource depends on a delegated subnet, verify all of the following before applying: the subnet has the exact required delegation, the delegation is not being removed by another Terraform resource or module, the subnet ID is passed to the resource, and incompatible resources such as private endpoints use a separate subnet when required by Azure.
- Design every new Azure module with a private connectivity path in mind: support private endpoints, private DNS integration, VNet integration, or other private networking options unless the user explicitly requests a public-only design.
- If an Azure API error names a required delegation or service association link, treat that message as authoritative evidence to reconcile against the exact resource documentation and provider version. Do not guess or reuse a legacy delegation.
- After changing a provider-specific requirement, run `terraform validate` and create a fresh `terraform plan`; never reuse a plan generated before the requirement changed.

## Required default posture
The repository default is: private access first, public access opt-in, and Azure resource design verified against the pinned Terraform provider and network requirements before implementation.
