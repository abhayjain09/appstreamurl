locals {
  lambda_zip_location = "../outputs/${var.name}.zip"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = local.lambda_zip_location
  #output_path = "${path.root}/.artifacts/aws/lambda/${var.name}.zip"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 30
  tags              = local.tags
}

resource "aws_lambda_function" "lambda" {
  function_name                  = var.name
  role                           = module.role.arn
  runtime                        = var.runtime
  handler                        = var.handler
  layers                         = var.layers
  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  filename                       = local.lambda_zip_location
  description                    = var.description
  #filename                       = "${path.root}/.artifacts/aws/lambda/${var.name}.zip" 
  tags = local.tags
}



data "aws_iam_policy_document" "invoke" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      aws_lambda_function.lambda.arn
    ]
  }
}
