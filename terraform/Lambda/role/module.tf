resource "aws_iam_role" "role" {
  name                  = var.name
  path                  = "/ops/"
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  description           = var.description
  force_detach_policies = true
  tags                  = local.tags
}

resource "aws_iam_role_policy_attachment" "policy" {
  for_each   = toset(var.policy_arns)
  role       = aws_iam_role.role.id
  policy_arn = each.key
}

# Merge Policy Documents to workaround limitations with for_each
module "merged-policy-document" {
  source           = "../merged-policy-document"
  policy_documents = var.policy_documents
}

# Attach Merged Policy Document to role
resource "aws_iam_role_policy" "instance" {
  count  = length(var.policy_documents) > 0 ? 1 : 0
  name   = "${var.name}-instance"
  role   = aws_iam_role.role.id
  policy = module.merged-policy-document.policy.document
}

# Grant service assume role permission
module "assume-role-policy-document" {
  source      = "../assume-role-policy-document"
  type        = "Service"
  identifiers = ["${var.service}.amazonaws.com"]
}

# allow adding a policy_document to the assume_role_policy
data "aws_iam_policy_document" "assume_role" {
  source_json   = module.assume-role-policy-document.policy.document
  override_json = var.assume_role_policy_document
}
