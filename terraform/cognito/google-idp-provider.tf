/*
resource "aws_cognito_user_pool" "example" {
  name                     = "example-pool"
  auto_verified_attributes = ["email"]
}
*/
resource "aws_cognito_identity_provider" "google_provider" {
  count         = var.auth_google_client_id != "" ? 1 : 0
  provider_name = "Google"
  provider_type = "Google"
  user_pool_id  = aws_cognito_user_pool.pool.id

  provider_details = {
    authorize_scopes = "profile email openid"
    client_id        = var.auth_google_client_id
    client_secret    = var.auth_google_client_secret
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}