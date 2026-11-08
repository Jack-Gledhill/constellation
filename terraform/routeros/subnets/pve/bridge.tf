locals {
  ports = ["ether5", "ether6", "ether7"]
}

resource "routeros_interface_bridge" "pve" {
  name           = "bridge[pve]"
  arp            = true
  vlan_filtering = false
}

resource "routeros_interface_ethernet" "ports" {
  for_each = local.ports

  factory_name     = each.value
  name             = "${each.value}[pve]"
  disabled         = false
  auto_negotiation = true
}

resource "routeros_interface_bridge_port" "all" {
  for_each = routeros_interface_ethernet.ports

  bridge    = routeros_interface_bridge.pve.name
  interface = each.value.factory_name
}
