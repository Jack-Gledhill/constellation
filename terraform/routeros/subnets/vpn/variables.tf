variable "private_key" {
  type        = string
  description = "Private key to use for the interface"
  sensitive   = true
}

variable "preshared_key" {
  type        = string
  description = "Preshared key for peers to use"
  sensitive   = true
}
