resource "aws_apigatewayv2_api" "gateway" {
  name          = "AppstreamUrlAutomation"
  protocol_type = "HTTP"
  tags          = local.tags
  description   = "A Http Api end point for internal automation"
}


resource "aws_apigatewayv2_authorizer" "auth" {
  api_id           = aws_apigatewayv2_api.gateway.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-AUTHORIZER"

  jwt_configuration {
    audience = var.audience   #[module.cognito.user_pool.client_id]
    issuer   = var.issuer      #"https://${module.cognito.user_pool.endpoint}"
  }
}

resource "aws_apigatewayv2_integration" "int" {
  api_id                 = aws_apigatewayv2_api.gateway.id
  integration_type       = "AWS_PROXY"
  connection_type        = "INTERNET"
  integration_method     = "POST"
  description            = "Lambda integration for GenerateAppStreamUrl"
  payload_format_version = "2.0"
  integration_uri        = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.GenerateAppStreamUrl-name}/invocations"
}

resource "aws_apigatewayv2_route" "route" {
  api_id             = aws_apigatewayv2_api.gateway.id
  route_key          = "GET /Appstream/Url"
  target             = "integrations/${aws_apigatewayv2_integration.int.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.auth.id
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.gateway.id
  name        = "$default"
  auto_deploy = true
  description = "Automatic deployment triggered by changes to the Api configuration"
  tags        = var.tags
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.GenerateAppStreamUrl-name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_apigatewayv2_api.gateway.execution_arn}/*/*/Appstream/Url"
}