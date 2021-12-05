variable "function_arn" {
  type        = string
  description = "The ARN of the lambda function."
}

variable "schedule_name" {
  type        = string
  description = "The name of the schedule for the lambda."
}

variable "schedule_expression" {
  type        = string
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)"
}

variable "input" {
  type        = string
  default     = null
  description = "Valid JSON text passed to the target."
}

variable "schedule_description" {
  type        = string
  default     = null
  description = "Specifies event for which to send notifications."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags associated with scheduled event lambda."
}

locals {
  schedule_description = coalesce(var.schedule_description, "${var.function_arn} - ${var.schedule_expression}")
  tags                 = merge(var.tags, { "ops/module" = "aws/scheduled-event-lambda", Name = var.schedule_name })
}
