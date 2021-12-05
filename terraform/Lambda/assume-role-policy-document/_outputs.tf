output "policy" {
  description = "Returns an assume role policy document that grants an IAM Role or AWS Service perms to assume a role."
  value = {
    document = data.aws_iam_policy_document.policy.json
  }
}

