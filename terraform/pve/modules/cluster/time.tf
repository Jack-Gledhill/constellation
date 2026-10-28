resource "proxmox_virtual_environment_time" "time" {
  for_each = var.nodes
  node_name = each
  time_zone = var.time_zone
}
