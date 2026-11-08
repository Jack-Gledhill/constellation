locals {
  subnet = "10.10.0.0/24"
}

resource "routeros_ip_address" "subnet" {
  comment   = "JetKVMs"
  address   = local.subnet
  interface = routeros_interface_bridge.kvm.name
}
