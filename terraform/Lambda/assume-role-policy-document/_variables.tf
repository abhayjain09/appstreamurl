variable "type" {
  type        = string
  default     = "AWS"
  description = "The type of principal.  Either AWS or Service"
}

variable "identifiers" {
  type        = list(string)
  description = "List of service identifiers allowed to assume role."
}
