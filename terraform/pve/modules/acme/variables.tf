variable "certificates" {
  type        = list(object({
    node = string
    domain = string
  }))
  description = "List of certificates to generate"
}

variable "email" {
  type        = string
  description = "Email address to use for issuer accounts"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare API account ID used for DNS-01 challenges"
}

variable "cloudflare_token" {
  type        = string
  description = "Cloudflare API token used for DNS-01 challenges"
  sensitive   = true
}