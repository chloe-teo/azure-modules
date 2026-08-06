# Terraform MCP Workflow Instructions

You are equipped with a local Terraform MCP Server running via Docker standard input/output (stdio). Follow these operational rules strictly.

## 1. Server Lifecycle Management
- If the Terraform MCP server is not currently running or active, do not ask the user to start it.
- Instead, output the required start command directly so the user can easily run it:
  `docker run -i --rm hashicorp/terraform-mcp-server:latest`

## 2. Workspace Version Alignment (Crucial)
- Before calling the Terraform MCP server for any module or provider details, you must locate and scan the local `providers.tf`, `main.tf`, or `versions.tf` files.
- Locate the `required_providers` configuration block to find the exact provider version constraint (e.g., `version = "~> 3.0"` or `source = "hashicorp/azurerm"`).
- Always supply this extracted version string using the exact version parameter name declared by the MCP tool schema. Do not default to the latest absolute registry version if the local workspace is locked to an older release.

## 3. MCP Tool Schema Preflight (Mandatory)
- Before the first call to any Terraform MCP tool in a session, inspect the tool definition returned by `tool_search` and confirm the exact required and optional JSON argument names, types, and meanings.
- Never invent, rename, or assume an argument key. For example, use `provider_version` only if the tool schema declares `provider_version`; use `version` only if the schema declares `version`.
- If the requested version parameter is not supported by the selected MCP tool, do not send the request as though it were version-specific. State that limitation and use a supported lookup or local Terraform validation instead.
- After a version-specific lookup, verify that the response identifies the requested provider version. If it returns a different version, treat the lookup as mismatched, report it, and do not use it as evidence for the workspace's pinned provider.

## 4. Formatting Strictness and Fallback Mechanism
- When calling the Terraform MCP server tools, always explicitly pass the `namespace` (e.g., "hashicorp") and the target `provider_doc_id` or `name` based on the user's prompt text to avoid JSON-RPC argument parsing validation errors.
- **Strict Parameter Fallback Rule:** If the user's prompt does not clearly define a namespace or provider name, or if you cannot determine them from the local workspace files, you must stop and ask the user a clarification question before executing the tool call. 
  - *Example Fallback Action:* If the user asks "How do I configure a database?", do not trigger an empty MCP call. Stop and say: *"Please specify which provider namespace and name you are using (e.g., hashicorp/azurerm or hashicorp/aws) so I can pass the correct arguments to the MCP server."*

## 5. Execution and Permission Rules
- **Safe Commands (Read-only / Diagnostics):** You are permitted to execute any baseline check, local code linting, directory discovery, or diagnostic validation commands immediately without asking for user permission.
- **MCP Server Tool Requests:** The very first time you need to execute a tool call or lookup payload through the `terraform` MCP server, stop and explain what data you are requesting. Present the parameters to the user for explicit confirmation before finalizing the request. Once verified for the session, you may query it smoothly.

# Terraform Best Practices and Module Structure

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
