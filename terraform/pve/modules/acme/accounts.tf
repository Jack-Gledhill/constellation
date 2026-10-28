resource "proxmox_acme_account" "letsencrypt" {
  name      = "letsencrypt"
  contact   = var.email
  directory = "https://acme-v02.api.letsencrypt.org/directory"
  tos       = "https://letsencrypt.org/documents/LE-SA-v1.6-August-18-2025.pdf"
}