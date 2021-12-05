resource "aws_cognito_user_pool_domain" "main" {
  domain       = local.qualified_name
  user_pool_id = aws_cognito_user_pool.pool.id
}
