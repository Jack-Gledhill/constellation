locals {
  nodes_subnet = "10.10.1.0/24"
}

resource "routeros_ip_address" "nodes" {
  comment   = "PVE nodes"
  address   = local.nodes_subnet
  interface = routeros_interface_bridge.pve.name
}
