resource "proxmox_acme_certificate" "certificate" {
  node_name = var.node
  account   = var.acme_account.name

  domains = [
    {
      domain = var.node + "starsystem.dev"
      plugin = var.acme_plugin.plugin
    }
  ]
}
