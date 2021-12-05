resource "aws_iam_role" "authenticated" {
  name               = "${local.qualified_name}-cognito-${var.region}"
  path               = "/cognito/"
  assume_role_policy = data.aws_iam_policy_document.authenticated-assume.json

  description = "The role used to represent identifies that were authenticated via the ${local.qualified_name} cognito identity pool."
}

data "aws_iam_policy_document" "authenticated-assume" {
  statement {
    sid     = "AllowAssumeWebIdentity"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        "cognito-identity.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.pool.id]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values   = ["authenticated"]
    }
  }
}
