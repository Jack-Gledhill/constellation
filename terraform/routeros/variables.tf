variable "ros_username" {
  type        = string
  description = "Username to login to RouterOS with"
  sensitive   = true
}

variable "ros_password" {
  type        = string
  description = "Password to login to RouterOS with"
  sensitive   = true
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

variable "wg_private_key" {
  type        = string
  description = "Private key to use for the WireGuard server"
  sensitive   = true
}

variable "wg_preshared_key" {
  type        = string
  description = "Preshared key to use with WireGuard peers"
  sensitive   = true
}
