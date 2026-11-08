variable "trusted_subnets" {
  type        = list(string)
  description = "List of subnets in CIDR notation that will be allowed to access system services"
}

variable "smtp_username" {
  type        = string
  description = "Username to use when authenticating with SMTP server"
  sensitive   = true
}

variable "smtp_password" {
  type        = string
  description = "Password to use when authenticating with SMTP server"
  sensitive   = true
}

variable "smtp_from" {
  type        = string
  description = "Sender address used when sending emails"
}
