resource "proxmox_virtual_environment_dns" "dns" {
  for_each = var.nodes
  node_name = each
  domain    = var.dns_domain

  servers = [
    "1.1.1.1",
    "1.0.0.1",
  ]
}
