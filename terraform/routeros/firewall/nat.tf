locals {
  port_forwarding_rules = [
    {
      comment      = "HTTP to Traefik"
      protocol     = "tcp"
      from_port    = "80"
      to_addresses = "10.30.3.2"
      to_ports     = "80"
    },
    {
      comment      = "HTTPS to Traefik"
      protocol     = "tcp"
      from_port    = "443"
      to_addresses = "10.30.3.2"
      to_ports     = "443"
    }
  ]
}

resource "routeros_ip_firewall_nat" "masquerade" {
  action             = "masquerade"
  chain              = "srcnat"
  comment            = "Masquerade"
  disabled           = false
  out_interface_list = var.wan_interface_list
}

resource "routeros_ip_firewall_nat" "port_forwarding" {
  depends_on = [routeros_ip_firewall_nat.masquerade]
  for_each   = local.port_forwarding_rules

  action            = "dst-nat"
  chain             = "dstnat"
  disabled          = false
  in_interface_list = var.wan_interface_list
  comment           = each.value.comment
  protocol          = each.value.protocol
  dst_port          = each.value.from_port
  to_addresses      = each.value.to_addresses
  to_ports          = each.value.to_ports
}

# These two dynamic port forwarding protocols don't serve much purpose within Constellation
# and pose a security risk if left enabled
resource "routeros_ip_nat_pmp" "config" {
  enabled = false
}

resource "routeros_ip_upnp" "config" {
  enabled = false
}
