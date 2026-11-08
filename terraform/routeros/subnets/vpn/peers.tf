locals {
  endpoint = "connect.starsystem.dev"
}

resource "routeros_interface_wireguard_peer" "macbook" {
  name         = "macbook"
  interface    = routeros_interface_wireguard.vpn.name
  is_responder = false # Indicates that this peer initiates the connection, i.e. acts as a client

  public_key           = "7thdQWSC4gfTI0aIs13hmwjdIbapm4jDZbOaHAPcIWk="
  preshared_key        = var.preshared_key
  persistent_keepalive = "25"
  allowed_address      = ["10.0.0.0/8"]

  client_address   = cidrhost(local.subnet, 2)
  client_dns       = local.gateway
  client_endpoint  = local.endpoint + ":" + routeros_interface_wireguard.vpn.listen_port
  client_keepalive = "25"
}
