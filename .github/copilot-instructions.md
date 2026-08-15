# Terraform MCP Rulebook

This repository requires the Terraform MCP server for all Terraform authoring, modification, and validation in this IDE.

## 1. Mandatory rule
- The agent must use the Terraform MCP server before finalizing any Terraform change.
- The agent must never author Terraform resources, modules, variables, outputs, providers, or data sources from memory when a provider contract or version-specific schema can be checked.
- This requirement applies to Azure resources, networking, storage, private endpoints, DNS zones, AKS, App Service, Function Apps, and any other infrastructure code in this repo.

## 2. Required workflow
1. The agent must review the local Terraform configuration and lock files before a lookup.
2. The agent must confirm the active provider version and any `required_providers` constraints in the workspace.
3. The agent must query the Terraform MCP server for the exact resource type, provider, and Azure-specific requirements for that pinned version.
4. The agent must implement the change using the MCP-validated contract rather than generic examples.
5. The agent must validate the result with the appropriate local Terraform checks after the change.

## 3. Version alignment
- The agent must treat the workspace version in `required_providers` and `.terraform.lock.hcl` as the source of truth.
- The agent must never silently upgrade or assume a newer provider version has the same schema or Azure requirements.
- If the configuration and lock file disagree, the agent must stop and resolve the mismatch before proceeding.
- If the MCP tool does not support version filtering, the agent must continue with a supported lookup while keeping the workspace version constraint in scope and must never treat the result as authoritative beyond that constraint.

## 4. MCP request contract
- Before each MCP lookup, the agent must confirm the provider namespace and the exact resource or module being used.
- The agent must use the exact argument names and expected types defined by the tool schema and must never invent or rename keys.
- If the user request is ambiguous, the agent must ask for the provider namespace or resource name before triggering the lookup.
- If an MCP result references a different provider version than the repo is pinned to, the agent must treat that result as mismatched and must never use it as evidence for the workspace implementation.

## 5. Private network default
- New Azure modules must be designed with private connectivity as the default path.
- The agent must prefer private endpoints, VNet integration, private DNS, delegated subnets, and restricted access before exposing public endpoints.
- Public access is an explicit opt-in and must be justified with a clear requirement.
- If a public endpoint is introduced, it must not remove or weaken the private access path.
- The agent must follow [.github/private-network-first.md](private-network-first.md) for the detailed private-network and Azure resource standards.

## 6. Validation and execution rules
- The agent may use safe read-only commands such as file inspection and diagnostic checks without prior approval.
- Any Terraform change must be followed by the appropriate validation step, such as `terraform validate` or a fresh `terraform plan`.
- The agent must never reuse stale plans after a network, provider, or resource requirement change.
- The first MCP request in a session may require explicit confirmation of the resource and parameters before finalizing the lookup.

## 7. Prohibited behavior
- The agent must never create or modify Terraform without the Terraform MCP server when the task is Terraform-related.
- The agent must never rely on generic examples or memory for Azure resource arguments, required fields, or networking constraints when the schema can be checked.
- The agent must never guess provider version, namespace, or resource properties when the repo already pins them.
- The agent must never treat public-by-default design as acceptable when private-network capability is available.
- Role assignments inside reusable modules must use generic resource names and configurable inputs; they must not be hard-coded to a specific consumer or purpose, such as `function_secrets`.
- The agent should avoid `count` for repeatable or optional resource instances; use `for_each` whenever a resource can have multiple instances or can be conditionally represented as a collection.

## Reference
- Follow the module structure and Terraform best practices in [.github/terraform-best-practices.md](terraform-best-practices.md).
- Follow the private-network-first and Azure resource standards in [.github/private-network-first.md](private-network-first.md).

## Summary
The repository default is: Terraform work requires Terraform MCP, and new Azure modules must assume private-network capability by default unless a public-only requirement is explicitly requested and justified.
