module "lan" {
  source = "lan"
}

resource "routeros_interface_list" "lan" {
  comment = "All physical and virtual interfaces within the local network"
  name    = "LAN"
}

resource "routeros_interface_list_member" "kvm" {
  interface = module.kvm.interface_name
  list      = routeros_interface_list.lan.name
}

resource "routeros_interface_list_member" "local" {
  interface = module.local.interface_name
  list      = routeros_interface_list.lan.name
}

resource "routeros_interface_list_member" "pve" {
  interface = module.pve.interface_name
  list      = routeros_interface_list.lan.name
}

resource "routeros_interface_list_member" "vpn" {
  interface = module.vpn.interface_name
  list      = routeros_interface_list.lan.name
}
