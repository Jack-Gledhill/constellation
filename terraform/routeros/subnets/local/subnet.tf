locals {
  subnet = "10.20.0.0/24"
}

resource "routeros_ip_address" "subnet" {
  comment   = "Local"
  address   = local.subnet
  interface = routeros_interface_bridge.local.name
}
