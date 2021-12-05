variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

variable "region" {
   type = string
   description = "current region"  
}
variable "AppStreamUrl_Route53HealthCheck_name" {
  type = string
  #module.GenerateAppStreamUrl.name
}

locals {
  tags           = merge(var.tags)
}
