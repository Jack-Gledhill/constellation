resource "proxmox_virtual_environment_dns" "dns" {
  domain    = "starsystem.dev"
  node_name = var.node

  servers = [
    "1.1.1.1",
    "1.0.0.1",
  ]
}
