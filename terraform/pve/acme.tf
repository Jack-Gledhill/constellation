resource "proxmox_acme_account" "letsencrypt" {
  name      = "letsencrypt"
  contact   = "admin@starsystem.dev"
  directory = "https://acme-v02.api.letsencrypt.org/directory"
  tos       = "https://letsencrypt.org/documents/LE-SA-v1.6-August-18-2025.pdf"
}

resource "proxmox_acme_dns_plugin" "cloudflare" {
  plugin = "cloudflare"
  api    = "cf"

  data = {
    CF_Account_ID = var.cloudflare_account_id
    CF_Token      = var.cloudflare_token
  }
}
