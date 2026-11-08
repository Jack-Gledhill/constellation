resource "routeros_interface_wireguard" "vpn" {
  name        = "wg1[vpn]"
  listen_port = "51820"
  mtu         = "1280" # Having the MTU this low can help with latency issues across double NAT
  private_key = var.private_key
}
