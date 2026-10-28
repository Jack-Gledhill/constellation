resource "proxmox_virtual_environment_time" "time" {
  node_name = var.node
  time_zone = "Europe/London"
}
