output "identity_pool" {
  value = {
    id  = aws_cognito_identity_pool.pool.id
    arn = aws_cognito_identity_pool.pool.arn
  }
  #description = "The identifier and arn of the cognito identity pool."
  sensitive = true
}
output "user_pool_client" {
  value = {
    #client_id     = local.is_callback ? aws_cognito_user_pool_client.client["true"].id : null
    #client_secret = local.is_callback ? aws_cognito_user_pool_client.client["true"].client_secret : null
    client_id     = aws_cognito_user_pool_client.client.id
    client_secret = aws_cognito_user_pool_client.client.client_secret
    userpool_name = local.userpool_name
    endpoint      = aws_cognito_user_pool.pool.endpoint
  }
}

output "user_pool" {
  value = {
    userpool_name = local.userpool_name
    id            = aws_cognito_user_pool.pool.id
    custom_domain = aws_cognito_user_pool.pool.custom_domain
    domain        = aws_cognito_user_pool.pool.domain
    arn           = aws_cognito_user_pool.pool.arn
    endpoint      = aws_cognito_user_pool.pool.endpoint
    #client_id     = local.is_callback ? aws_cognito_user_pool_client.client["true"].id : null
    #client_secret = local.is_callback ? aws_cognito_user_pool_client.client["true"].client_secret : null
  }
  #sensitive = true
  description = "The identifier and arn of the cognito user pool."
}
/*
output "oidc" {
  value = ! local.is_oidc ? null : {
    provider = var.oidc_provider
    issuer   = var.oidc_issuer
    scopes   = var.oidc_scopes
  }
  description = "The name, issuer, and scopes of the oidc identity provider."
}

output "distribution" {
  value = {
    domain  = aws_cognito_user_pool_domain.domain.domain
    arn     = aws_cognito_user_pool_domain.domain.cloudfront_distribution_arn
    bucket  = aws_cognito_user_pool_domain.domain.s3_bucket
    version = aws_cognito_user_pool_domain.domain.version
  }
  description = "The details for the CloudFront distribution used to host the cognito UI."
}

output "authenticated_policy" {
  value = {
    arn      = aws_iam_policy.authenticated.arn
    document = aws_iam_policy.authenticated.policy
  }
  description = "The policy to use for authenticated users."
}

output "assume_policy" {
  value = {
    document = data.aws_iam_policy_document.assume.json
  }
  description = "The policy to use to allow cognito authenticated users to assume other roles."
}
*/