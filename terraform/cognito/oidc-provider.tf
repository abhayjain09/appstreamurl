/*
resource "aws_cognito_identity_provider" "oidc" {
  for_each      = local.has_oidc
  user_pool_id  = aws_cognito_user_pool.pool.id
  provider_name = var.oidc_provider
  provider_type = "OIDC"

  provider_details = {
    oidc_issuer                   = var.oidc_issuer
    client_id                     = var.oidc_client_id
    client_secret                 = var.oidc_client_secret
    authorize_scopes              = join(" ", var.oidc_scopes)
    attributes_request_method     = "GET"
    attributes_url_add_attributes = "false"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}
*/