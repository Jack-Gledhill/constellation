locals {
  filter_order = [
    routeros_ip_firewall_filter.drop_invalid_forward,
    routeros_ip_firewall_filter.drop_invalid_input,
    routeros_ip_firewall_filter.allow_outbound,
    routeros_ip_firewall_filter.allow_lan_to_lan,
    routeros_ip_firewall_filter.allow_lan_to_router,
    routeros_ip_firewall_filter.fasttrack_established_related,
    routeros_ip_firewall_filter.allow_established_related_input,
    routeros_ip_firewall_filter.allow_established_related_forward,
    routeros_ip_firewall_filter.allow_local_loopback,
    routeros_ip_firewall_filter.allow_pings,
    routeros_ip_firewall_filter.allow_inbound_wg,
    routeros_ip_firewall_filter.allow_inbound_dnat,
    routeros_ip_firewall_filter.drop_inbound_input,
    routeros_ip_firewall_filter.drop_inbound_forward,
  ]
}

resource "routeros_ip_firewall_filter" "drop_invalid_forward" {
  comment          = "Drop invalid (forward)"
  action           = "drop"
  chain            = "forward"
  connection_state = "invalid"
  disabled         = false
}

resource "routeros_ip_firewall_filter" "drop_invalid_input" {
  comment          = "Drop invalid (input)"
  action           = "drop"
  chain            = "input"
  connection_state = "invalid"
  disabled         = false
}

resource "routeros_ip_firewall_filter" "allow_outbound" {
  comment            = "Allow outbound"
  action             = "accept"
  chain              = "forward"
  out_interface_list = var.wan_interface_list
  disabled           = false
}

resource "routeros_ip_firewall_filter" "allow_lan_to_lan" {
  comment            = "Allow LAN to LAN"
  action             = "accept"
  chain              = "forward"
  in_interface_list  = var.lan_interface_list
  out_interface_list = var.lan_interface_list
  disabled           = false
}

resource "routeros_ip_firewall_filter" "allow_lan_to_router" {
  comment           = "Allow LAN to router"
  action            = "accept"
  chain             = "input"
  in_interface_list = var.lan_interface_list
  disabled          = false
}

resource "routeros_ip_firewall_filter" "fasttrack_established_related" {
  comment          = "FastTrack established and related"
  action           = "fasttrack connection"
  chain            = "forward"
  connection_state = "established,related"
  disabled         = false
  hw_offload       = true
}

resource "routeros_ip_firewall_filter" "allow_established_related_input" {
  comment          = "Allow established and related (input)"
  action           = "accept"
  chain            = "input"
  connection_state = "established,related"
  disabled         = false
}

resource "routeros_ip_firewall_filter" "allow_established_related_forward" {
  comment          = "Allow established and related (forward)"
  action           = "accept"
  chain            = "forward"
  connection_state = "established,related"
  disabled         = false
}

resource "routeros_ip_firewall_filter" "allow_local_loopback" {
  comment     = "Allow local loopback"
  action      = "accept"
  chain       = "input"
  dst_address = "127.0.0.1"
  disabled    = false
}

resource "routeros_ip_firewall_filter" "allow_pings" {
  comment  = "Allow pings"
  action   = "accept"
  chain    = "input"
  protocol = "icmp"
  disabled = false
}

resource "routeros_ip_firewall_filter" "allow_inbound_wg" {
  comment           = "Allow inbound wg1 handshake"
  action            = "accept"
  chain             = "input"
  protocol          = "udp"
  in_interface_list = var.wan_interface_list
  dst_port          = var.wg_port
  disabled          = false
}

resource "routeros_ip_firewall_filter" "allow_inbound_dnat" {
  comment              = "Allow inbound DNATed"
  action               = "accept"
  chain                = "forward"
  connection_nat_state = "dstnat"
  in_interface_list    = var.wan_interface_list
  disabled             = false
}

resource "routeros_ip_firewall_filter" "drop_inbound_input" {
  comment           = "Drop inbound (input)"
  action            = "drop"
  chain             = "input"
  in_interface_list = var.wan_interface_list
  disabled          = false
}

resource "routeros_ip_firewall_filter" "drop_inbound_forward" {
  comment           = "Drop inbound (forward)"
  action            = "drop"
  chain             = "forward"
  in_interface_list = var.wan_interface_list
  disabled          = false
}

resource "routeros_move_items" "filter_rules" {
  resource_path = "/ip/firewall/filter"
  sequence      = [for r in local.filter_order : r.id]
}
