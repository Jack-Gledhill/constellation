locals {
  dns_search_domain = "starsystem.dev"

  gateway     = cidrhost(local.subnet, 1)
  range_start = cidrhost(local.subnet, 2)
  range_end   = cidrhost(local.subnet, -2)
}

resource "routeros_ip_dhcp_server_network" "kvm" {
  comment    = "JetKVM"
  address    = local.subnet
  gateway    = local.gateway
  domain     = local.dns_search_domain
  dns_server = [local.gateway]
  ntp_server = [local.gateway]
  dns_none   = false
  ntp_none   = false
}

resource "routeros_ip_pool" "kvm" {
  name    = "pool[kvm]"
  comment = "JetKVM"
  ranges  = ["${local.range_start}-${local.range_end}"]
}

resource "routeros_ip_dhcp_server" "kvm" {
  depends_on = [routeros_ip_dhcp_server_network.kvm]

  name               = "dhcp[kvm]"
  comment            = "JetKVM"
  address_pool       = routeros_ip_pool.kvm.name
  interface          = routeros_interface_bridge.kvm.name
  authoritative      = "yes"
  lease_time         = "12:00:00"
  conflict_detection = true
  disabled           = false
  use_reconfigure    = true
  add_arp            = true
}
