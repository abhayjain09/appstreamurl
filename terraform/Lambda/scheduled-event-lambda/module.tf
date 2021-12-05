resource "aws_cloudwatch_event_rule" "rule" {
  name                = var.schedule_name
  description         = local.schedule_description
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "target" {
  rule      = aws_cloudwatch_event_rule.rule.name
  target_id = "lambda"
  arn       = var.function_arn
  input     = var.input
}

resource "aws_lambda_permission" "permission" {
  statement_id  = "AllowCloudwatchInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule.arn
}
