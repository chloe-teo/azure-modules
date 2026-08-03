variable "scope"{
    description = "The scope of the role assignment"
    type        = string
}

variable "role_definition_name" {
    description = "The name of the role definition"
    type        = string
}

variable "principal_id" {
    description = "The principal ID of the role assignment"
    type        = string
}