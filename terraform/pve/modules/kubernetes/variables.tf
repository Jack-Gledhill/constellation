variable "username" {
  type        = string
  description = "Username including realm of the service account"
}

variable "password" {
  type        = string
  description = "Password of the service account"
  sensitive   = true
}
