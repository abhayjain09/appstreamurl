variable "name" {
  type        = string
  description = "The name of the IAM role to create."

  validation {
    condition     = can(regex("^[[:alpha:]]+[[:alnum:]-]+[[:alnum:]]+$", var.name))
    error_message = "The name must contain only letters, numbers, or hypen (-). It must start with a letter and cannot end with a hyphen."
  }
}

variable "description" {
  type        = string
  default     = null
  description = "Description of the IAM role."
}

variable "service" {
  type        = string
  description = "The name of service allowed to assume role ie lambda or ec2."
}

variable "policy_documents" {
  type        = list(string)
  default     = []
  description = "List of IAM Policy Documents for the role."
}

variable "assume_role_policy_document" {
  type        = string
  default     = null
  description = "(Optional) List of IAM Policy Documents allowed to assume the role. Takes a json encoded string"
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "List of default IAM policy ARNs for role."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the role."
}

locals {
  tags = merge(var.tags, { "ops/module" = "aws/role" })
}
