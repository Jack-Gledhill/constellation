resource "proxmox_acme_dns_plugin" "cloudflare" {
  plugin = "cloudflare"
  api    = "cf"

  data = {
    CF_Account_ID = var.cloudflare_account_id
    CF_Token      = var.cloudflare_token
  }
}