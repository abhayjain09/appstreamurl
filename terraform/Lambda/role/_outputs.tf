# output "role" {
#   value = {
#     id                   = aws_iam_role.role.id
#     unique_id            = aws_iam_role.role.unique_id
#     arn                  = aws_iam_role.role.arn
#     max_session_duration = aws_iam_role.role.max_session_duration
#   }
#   description = "The role id and arn."
# }

output "id" {
  value       = aws_iam_role.role.id
  description = "The name of the role."
}

output "unique_id" {
  value       = aws_iam_role.role.unique_id
  description = "The stable and unique string identifying the role."
}

output "arn" {
  value       = aws_iam_role.role.arn
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "max_session_duration" {
  value       = aws_iam_role.role.max_session_duration
  description = "The maximum session duration (in seconds)."
}
