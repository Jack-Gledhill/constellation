resource "proxmox_acme_certificate" "nodes" {
  for_each = { for c in var.certificates: c.node => c }
  node_name = each.key
  account   = proxmox_acme_account

  domains = [
    {
      domain = each.value.domain
      plugin = proxmox_acme_dns_plugin
    }
  ]
}