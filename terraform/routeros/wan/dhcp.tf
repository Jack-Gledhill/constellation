resource "routeros_ip_dhcp_client" "ether1" {
  interface         = routeros_interface_ethernet.ether1.factory_name
  add_default_route = "yes"
  disabled          = false
  use_peer_dns      = false
  use_peer_ntp      = false
}
