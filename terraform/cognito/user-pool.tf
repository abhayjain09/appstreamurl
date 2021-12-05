resource "aws_cognito_user_pool" "pool" {
  name = local.userpool_name
  #alias_attributes = ["email"]
  tags = local.tags
  username_configuration {
    case_sensitive = false
  }
  mfa_configuration        = "OFF"
  auto_verified_attributes = ["email"]
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
}

resource "aws_cognito_user_pool_client" "client" {
  #for_each = local.has_callback

  name         = local.qualified_name
  user_pool_id = aws_cognito_user_pool.pool.id
  #supported_identity_providers = [var.oidc_provider]
  supported_identity_providers         = ["Google"] #need to remove by Abhay
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = var.oidc_scopes
  prevent_user_existence_errors        = "ENABLED"
  enable_token_revocation              = false
  callback_urls                        = var.oidc_callback_urls
  generate_secret                      = true
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  depends_on = [
    #aws_cognito_identity_provider.oidc["true"]
    aws_cognito_identity_provider.google_provider["true"]
  ]
}
