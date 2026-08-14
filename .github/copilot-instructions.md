# Terraform MCP Rulebook

This repository requires the Terraform MCP server for all Terraform authoring and modification in this IDE.

## Mandatory rule
- If the task involves creating, editing, updating, refactoring, or validating Terraform code, the Terraform MCP server must be used before finalizing the change.
- Do not write Terraform resources, modules, variables, outputs, providers, or data sources directly from memory when the MCP server can provide version-specific provider and resource guidance.
- This is mandatory for Azure resources, networking resources, storage, private endpoints, DNS zones, AKS, App Service, Function Apps, and any other Terraform code in this workspace.

## Required workflow
1. Check the local Terraform version and provider constraints in the workspace before using the MCP server.
2. Read the active provider version from the workspace configuration and lock file (`required_providers`, `.terraform.lock.hcl`, or equivalent) and confirm it before any Terraform MCP lookup.
3. Use the Terraform MCP server to confirm provider names, resource schema, required arguments, and Azure-specific best practices for that exact pinned provider version.
4. Use the MCP server results to guide the exact Terraform code you write or modify.
5. Validate the updated Terraform with the appropriate local commands after the change.

## Strict instruction to the agent
- When asked to generate or update Terraform code in this IDE, always prefer the Terraform MCP server over ad hoc assumptions.
- Never hand-author Terraform for Azure or other providers without checking the MCP server for the exact resource contract and version requirements.
- If the workspace already declares a provider version or resource constraint, honor it and do not silently upgrade or change it without checking the MCP server and the local configuration.
- If you are unsure which provider or resource is in use, inspect the local Terraform files first, then use the Terraform MCP server to confirm the correct schema and arguments.

## Tooling expectations
- The Terraform MCP server is the source of truth for Terraform provider documentation and resource behavior in this repository.
- The IDE agent must treat Terraform MCP usage as a required part of Terraform work, not an optional extra.
- Local Terraform validation commands may still be used for syntax and plan checks, but they do not replace the required MCP lookup for provider/resource guidance.

## Workspace Version Alignment (Crucial)
- Before calling the Terraform MCP server for any module or provider details, you must locate and scan the local `providers.tf`, `main.tf`, `versions.tf`, and `.terraform.lock.hcl` files.
- Locate the `required_providers` configuration block and the resolved provider lock entry to find the exact provider version constraint and pinned version used by the workspace (for example, `version = "~> 3.0"` or provider entries in `.terraform.lock.hcl`).
- Treat the workspace’s pinned version as the source of truth. Do not default to the latest provider version or a different release when the repository is locked to an older provider.
- Always supply this extracted version string using the exact version parameter name declared by the MCP tool schema. If the tool does not support a version parameter, do not invent one; instead, note the limitation and continue with the supported lookup while keeping the workspace version constraint in scope.
- If the workspace configuration and lock file disagree, stop and resolve the mismatch before continuing; do not proceed with MCP guidance based on an assumed version.

## MCP Tool Schema Preflight (Mandatory)
- Before the first call to any Terraform MCP tool in a session, inspect the tool definition returned by `tool_search` and confirm the exact required and optional JSON argument names, types, and meanings.
- Never invent, rename, or assume an argument key. For example, use `provider_version` only if the tool schema declares `provider_version`; use `version` only if the schema declares `version`.
- Before sending a versioned request, check the workspace provider constraint and lock file, then pass that exact version value only if the MCP tool supports it.
- If the requested version parameter is not supported by the selected MCP tool, do not send the request as though it were version-specific. State that limitation and use a supported lookup or local Terraform validation instead.
- After a version-specific lookup, verify that the response identifies the requested provider version. If it returns a different version, treat the lookup as mismatched, report it, and do not use it as evidence for the workspace's pinned provider.

## 4. Formatting Strictness and Fallback Mechanism
- When calling the Terraform MCP server tools, always explicitly pass the `namespace` (e.g., "hashicorp") and the target `provider_doc_id` or `name` based on the user's prompt text to avoid JSON-RPC argument parsing validation errors.
- Strict Parameter Fallback Rule: If the user's prompt does not clearly define a namespace or provider name, or if you cannot determine them from the local workspace files, stop and ask the user a clarification question before executing the tool call.
  - Example: If the user asks "How do I configure a database?", do not trigger an empty MCP call. Ask: "Please specify which provider namespace and name you are using (for example, hashicorp/azurerm or hashicorp/aws) so I can pass the correct arguments to the MCP server."

## 5. Execution and Permission Rules
- Safe Commands (Read-only / Diagnostics): You are permitted to execute baseline checks, local code linting, directory discovery, and diagnostic validation commands immediately without asking for user permission.
- MCP Server Tool Requests: The first time you need to execute a tool call or lookup payload through the Terraform MCP server, explain what data you are requesting and present the parameters for confirmation before finalizing the request. Once verified for the session, you may query it normally.

## 6. Azure Resource Requirements (Mandatory)
- Before generating or changing Azure Terraform code, identify the exact AzureRM resource type and hosting model in use. Do not infer requirements from similarly named legacy resources.
- Use the Terraform MCP server to confirm the provider version and resource schema for the exact resource type. Do not assume that a newer provider version has the same requirements as an older one.
- Use the Terraform MCP server when creating or updating Azure Terraform code to confirm the correct properties for the exact resource.
- For service-specific requirements such as subnet delegation, delegated service names, supported SKUs, API fields, identity settings, or networking constraints, consult the pinned AzureRM provider documentation or schema before proposing the implementation.
- For Azure Functions, distinguish the hosting model explicitly. In particular, `azurerm_function_app_flex_consumption` requires the integration subnet delegation `Microsoft.App/environments`; do not substitute `Microsoft.Web/serverFarms`, which applies to different App Service hosting scenarios.
- When a resource depends on a delegated subnet, verify all of the following before applying: the subnet has the exact required delegation, the delegation is not being removed by another Terraform resource or module, the subnet ID is passed to the resource, and incompatible resources such as private endpoints use a separate subnet when required by Azure.
- If an Azure API error names a required delegation or service association link, treat that message as authoritative evidence to reconcile against the exact resource documentation and provider version. Do not guess or reuse a legacy delegation.
- After changing a provider-specific requirement, run `terraform validate` and create a fresh `terraform plan`; never reuse a plan generated before the requirement changed.

## Prohibited behavior
- Do not create Terraform code without using the Terraform MCP server when the task is Terraform-related.
- Do not rely on generic examples or prior memory alone for Azure Terraform resource configuration.
- Do not guess resource arguments, required fields, or Azure-specific constraints when the MCP server can confirm them.

## Reference
- Follow the module structure and Terraform best practices defined in [.github/terraform-best-practices.md](terraform-best-practices.md).

## Summary
The default position for this repo is: Terraform work requires Terraform MCP. If the task touches Terraform, use the MCP server first and use it consistently throughout the change.
