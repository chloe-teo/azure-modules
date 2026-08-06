variable "scope"{
    description = "The scope of the role assignment"
    type        = string
        validation {
            condition     = trimspace(var.scope) != ""
            error_message = "scope must not be empty."
        }
}

variable "role_definition_name" {
    description = "The name of the role definition"
    type        = string
        validation {
            condition     = trimspace(var.role_definition_name) != ""
            error_message = "role_definition_name must not be empty."
        }
}

variable "principal_id" {
    description = "The principal ID of the role assignment"
    type        = string
        validation {
            condition     = trimspace(var.principal_id) != ""
            error_message = "principal_id must not be empty."
        }
}