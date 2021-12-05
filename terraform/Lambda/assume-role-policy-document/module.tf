data "aws_iam_policy_document" "policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.type
      identifiers = var.identifiers
    }
  }
}
