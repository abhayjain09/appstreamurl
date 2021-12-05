variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

variable "audience" {
 type = list(string)
 description = "audience value for jwt_configuration"  
}

variable "issuer" {
   type = string
   description = "issuer value for jwt_configuration"  
}
variable "GenerateAppStreamUrl-name" {
  type = string
  #module.GenerateAppStreamUrl.name
}

locals {
  tags           = merge(var.tags)
}
