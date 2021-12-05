resource "aws_cognito_identity_pool" "pool" {
  identity_pool_name               = replace(local.qualified_name, "-", " ")
  allow_unauthenticated_identities = var.enable_anonymous_access

  tags = local.tags

  lifecycle {
    ignore_changes = [
      cognito_identity_providers
    ]
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "pool" {
  identity_pool_id = aws_cognito_identity_pool.pool.id

  roles = {
    "authenticated" = aws_iam_role.authenticated.arn
  }

  lifecycle {
    ignore_changes = [
      role_mapping
    ]
  }
}
