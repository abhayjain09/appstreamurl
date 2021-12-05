resource "aws_iam_policy" "authenticated" {
  name   = trim("${local.qualified_name}-cognito-${var.region}", "-")
  path   = "/cognito/"
  policy = data.aws_iam_policy_document.authenticated.json

  description = "A policy that allows an identity that was authenticated via the ${local.qualified_name} cognito identity pool to access resources within cognito."
}

data "aws_iam_policy_document" "authenticated" {
  statement {
    sid = "AllowCognito"

    actions = [
      "mobileanalytics:PutEvents",
      "cognito-sync:*",
      "cognito-identity:*"
    ]

    resources = [
      "*"
    ]
  }
}
