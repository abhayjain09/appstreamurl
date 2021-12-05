data "aws_iam_policy_document" "assume" {
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
  }
}
