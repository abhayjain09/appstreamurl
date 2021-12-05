variable "name" {
  type        = string
  description = "The name of the cognito user and identity pool."
}
/*
variable "domain" {
  type        = string
  description = "The domain name used to host the cognito user experience in cloudfront. This will be prefixed with `auth.`"
}

variable "certificate_arn" {
  type        = string
  description = "The ARN of the Amazon Certificate Manager (ACM) certificate for the cognito domain."
}
*/
variable "region" {
  type        = string
  default     = ""
  description = "region for the cognito domain."
}
variable "enable_anonymous_access" {
  type        = bool
  default     = false
  description = "A value indicating whether or not to enable anonymous access within the identity pool."
}

variable "oidc_provider" {
  type        = string
  default     = "SAM-IS"
  description = "The name of the oidc provider. DEFAULT: SAM-IS"
}

variable "oidc_client_id" {
  type        = string
  default     = null
  description = "The client id assigned to the product / project by the IDP, such as SAM-IS."
}

variable "oidc_client_secret" {
  type        = string
  default     = null
  description = "The client secret assigned to the product / project by the IDP, such as SAM-IS."
}
variable "oidc_issuer" {
  type        = string
  default     = "https://sam.ihsmarkit.com:443/sso/oauth2"
  description = "The URL of the oidc issuer. DEFAULT: https://sam.ihsmarkit.com:443/sso/oauth2"

}
variable "oidc_callback_urls" {
  type        = list(string)
  default     = []
  description = "The callback URL that the IDP should redirect to after authentication."
}

variable "oidc_scopes" {
  type = list(string)
  #default = ["openid", "email", "profile"]
  default     = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  description = "The list of scopes to request from the oidc issuer. DEFAULT: openid email profile"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

variable "auth_google_client_id" {
  type        = string
  description = "The client id assigned to the product / project by the IDP, such as Google"
}
variable "auth_google_client_secret" {
  type        = string
  description = "The client secret assigned to the product / project by the IDP, such as Google"
}



locals {
  is_oidc  = var.oidc_client_id != null && var.oidc_client_secret != null
  has_oidc = toset(local.is_oidc ? ["true"] : [])

  is_callback  = local.is_oidc && length(var.oidc_callback_urls) > 0
  has_callback = toset(local.is_callback ? ["true"] : [])

  #domain         = "auth.${var.domain}"
  qualified_name = lower(trim(replace(var.name, "/[[:punct:]]/", "-"), "-"))
  userpool_name  = upper(local.qualified_name)
  tags           = merge(var.tags, { "ops/module" = "aws/cognito" })
}
