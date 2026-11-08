locals {
  ports = ["ether2", "ether3", "ether4"]
}

resource "routeros_interface_bridge" "local" {
  name           = "bridge[local]"
  arp            = true
  vlan_filtering = false
}

resource "routeros_interface_ethernet" "ports" {
  for_each = local.ports

  factory_name     = each.value
  name             = "${each.value}[local]"
  disabled         = false
  auto_negotiation = true
}

resource "routeros_interface_bridge_port" "all" {
  for_each = routeros_interface_ethernet.ports

  bridge    = routeros_interface_bridge.local.name
  interface = each.value.factory_name
}
