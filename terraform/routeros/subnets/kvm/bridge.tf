locals {
  ports = ["ether8", "ether9", "ether10"]
}

resource "routeros_interface_bridge" "kvm" {
  name           = "bridge[kvm]"
  arp            = true
  vlan_filtering = false
}

resource "routeros_interface_ethernet" "ports" {
  for_each = local.ports

  factory_name     = each.value
  name             = "${each.value}[kvm]"
  disabled         = false
  auto_negotiation = true
}

resource "routeros_interface_bridge_port" "all" {
  for_each = routeros_interface_ethernet.ports

  bridge    = routeros_interface_bridge.kvm.name
  interface = each.value.factory_name
}
