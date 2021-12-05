resource "aws_apigatewayv2_api" "gateway_healthcheck" {
  name          = "AppstreamUrlHealthChecks"
  protocol_type = "HTTP"
  tags          = var.tags
  description   = "A Http Api end point Used for Route53 health check"
}


resource "aws_apigatewayv2_integration" "int_healthcheck" {
  api_id                 = aws_apigatewayv2_api.gateway_healthcheck.id
  integration_type       = "AWS_PROXY"
  connection_type        = "INTERNET"
  integration_method     = "POST"
  description            = "Lambda integration for route53 health check"
  payload_format_version = "2.0"
  integration_uri        = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.AppStreamUrl_Route53HealthCheck_name}/invocations"
}

resource "aws_apigatewayv2_route" "route1" {
  api_id    = aws_apigatewayv2_api.gateway_healthcheck.id
  route_key = "GET /ShortUrl/Route53/HealthCheck"
  target    = "integrations/${aws_apigatewayv2_integration.int_healthcheck.id}"

}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.gateway_healthcheck.id
  name        = "$default"
  auto_deploy = true
  description = "Automatic deployment triggered by changes to the Api configuration"
  tags        = var.tags
}

resource "aws_lambda_permission" "lambda_permission1" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.AppStreamUrl_Route53HealthCheck_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_apigatewayv2_api.gateway_healthcheck.execution_arn}/*/*/ShortUrl/Route53/HealthCheck"
}


resource "aws_route53_health_check" "example" {
  fqdn              = "${aws_apigatewayv2_api.gateway_healthcheck.id}.execute-api.${var.region}.amazonaws.com"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/ShortUrl/Route53/HealthCheck"
  failure_threshold = "3"
  request_interval  = "30"
  tags              = merge(var.tags, { "Name" = "AppstreamUrl-HealthCheck-${var.region}" })
}