locals {
  guests_subnet = "10.30.0.0/16"
}

resource "routeros_ip_address" "guests" {
  comment   = "PVE guests"
  address   = local.guests_subnet
  interface = routeros_interface_bridge.pve.name
}
