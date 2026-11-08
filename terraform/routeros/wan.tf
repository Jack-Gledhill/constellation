module "wan" {
  source = "wan"
}

resource "routeros_interface_list" "wan" {
  comment = "Matches all interfaces providing a link to the internet"
  name    = "WAN"
}

resource "routeros_interface_list_member" "wan" {
  for_each = module.wan.ports

  interface = each.value
  list      = routeros_interface_list.wan.name
}
