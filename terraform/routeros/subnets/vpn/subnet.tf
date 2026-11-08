locals {
  subnet  = "10.20.1.0/24"
  gateway = cidrhost(local.subnet, 1)
}

resource "routeros_ip_address" "subnet" {
  comment   = "VPN"
  address   = local.subnet
  interface = routeros_interface_wireguard.vpn.name
}
