locals {
  dns_search_domain = "starsystem.dev"

  gateway     = cidrhost(local.subnet, 1)
  range_start = cidrhost(local.subnet, 2)
  range_end   = cidrhost(local.subnet, -2)
}

resource "routeros_ip_dhcp_server_network" "local" {
  comment    = "Local"
  address    = local.subnet
  gateway    = local.gateway
  domain     = local.dns_search_domain
  dns_server = [local.gateway]
  ntp_server = [local.gateway]
  dns_none   = false
  ntp_none   = false
}

resource "routeros_ip_pool" "local" {
  name    = "pool[local]"
  comment = "Local"
  ranges  = ["${local.range_start}-${local.range_end}"]
}

resource "routeros_ip_dhcp_server" "mgmt" {
  depends_on = [routeros_ip_dhcp_server_network.local]

  name               = "dhcp[local]"
  comment            = "Local"
  address_pool       = routeros_ip_pool.local.name
  interface          = routeros_interface_bridge.local.name
  authoritative      = "yes"
  lease_time         = "12:00:00"
  conflict_detection = true
  disabled           = false
  use_reconfigure    = true
  add_arp            = true
}
