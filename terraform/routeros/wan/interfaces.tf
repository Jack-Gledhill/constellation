locals {
  ports = ["ether1"]
}

resource "routeros_interface_ethernet" "all" {
  for_each = local.ports

  factory_name     = each.value
  name             = each.value + "[wan]"
  disabled         = false
  auto_negotiation = true
}
