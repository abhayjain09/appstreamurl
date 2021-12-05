variable "region" {
  type = string
  #default     = "us-west-2"
  description = "AWS Region to deploy to"
}

variable "RDS_Monitoring_Dashboard" {
  type        = bool
  default     = false
  description = "Put this value to ture if need to deploy RDS_Monitoring_Dashboard"
}
#need to check
variable "userpool_name" {
  type = string
  default = "TERRAFORM-TEST-ABHAY"
  description = "The name of the cognito user and identity pool."
}
variable "tags" {
  type = map(string)
  default = { CreatedBy = "Abhay.Lunkad",
  "ops/managed-by" = "terraform" }
  description = "Additional tags associated with the resource."
}
variable "EC2_CPUUtilization_Dashboard" {
  type        = bool
  default     = false
  description = "Put this value to ture if need to deploy EC2_CPUUtilizationDashboard"
}
variable "environment" {
  type        = string
  default     = null
  description = "Env value"
}
variable "Appstream_CapacityUtilization_Dashboard" {
  type        = bool
  default     = false
  description = "Put this value to ture if need to deploy Appstream_CapacityUtilization_Dashboard"
}
/*
variable "primaryregion" {
  type        = string
  default     = var.region
  description = "This is the primary region for Appstream url automation."
}
*/
variable "regionlistmap" {
  type = map(string)
  default = {
    "us-east-1"      = "us-west-2",
    "us-west-2"      = "us-east-1",
    "eu-central-1"   = "eu-west-1",
    "eu-west-1"      = "eu-central-1",
    "ap-southeast-1" = "ap-northeast-1",
    "ap-northeast-1" = "ap-southeast-1"
  }
  description = "this map is use for "
}
/*
variable "secondaryregion" {
  type    = string
  default = regionlistmap(var.region)
  description = "This is the secondary region for Appstream url automation."
}
*/

variable "oidc_provider" {
  type        = string
  default     = null
  description = "name of the provider, default: SAM-IS"
}
#need to check #need to delete   default     = "need to delete"
variable "oidc_client_id" {
  type        = string
  default     = "need to delete"
  description = "oidc_client_id enable oidc integration with cognito"
}
#need to check #need to delete   default     = "need to delete"
variable "oidc_client_secret" {
  type        = string
  default     = "need to delete"
  description = "oidc_client_secret enable oidc integration with cognito"
}

variable "oidc_issuer" {
  type        = string
  default     = "https://sam.ihsmarkit.com:443/sso/oauth2"
  description = "the URL of the oidc issuer, default: https://sam.ihsmarkit.com:443/sso/oauth2"
}
variable "oidc_callback_urls" {
  type        = string
  default     = "https://appstream.gurudevhardware.online/Callback"
  description = "oidc_callback_urls enable oidc integration with cognito"
}