variable "pve_api_token" {
  type        = string
  description = "Proxmox VE API token including the username and realm"
  sensitive   = true
}

variable "pve_endpoint" {
  type        = string
  description = "HTTP address of the Proxmox host to connect to"
}

variable "pve_insecure" {
  type        = bool
  description = "Set to true to skip SSL certificate verification"
  default     = false
}

variable "pbs_server" {
  type        = string
  description = "Address of Proxmox Backup Server to configure as a storage destination"
}

variable "pbs_username" {
  type        = string
  description = "Username to use when authenticating to Proxmox Backup Server"
}

variable "pbs_password" {
  type        = string
  description = "Password to use when authenticating to Proxmox Backup Server"
  sensitive   = true
}

variable "pbs_fingerprint" {
  type        = string
  description = "Fingerprint of the Proxmox Backup Server"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare API account ID used for ACME DNS challenges"
}

variable "cloudflare_token" {
  type        = string
  description = "Cloudflare API token used for ACME DNS challenges"
  sensitive   = true
}

variable "kubernetes_username" {
  type        = string
  description = "Username of the user to create for the Kubernetes service account"
}

variable "kubernetes_password" {
  type        = string
  description = "Password of the user to create for the Kubernetes service account"
  sensitive   = true
}
