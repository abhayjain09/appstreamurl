variable "policy_documents" {
  type        = list(string)
  default     = []
  description = "List of AWS IAM Policy Documents in json format to merge."
}

locals {
  documents = [for document in var.policy_documents : jsondecode(document)]
  statements = flatten([
    for document in local.documents : [
      for statement in document.Statement :
      statement
    ]
  ])
  document = jsonencode({ Version = "2012-10-17", Statement = local.statements })
}