locals {
  upstream_dns_servers = ["1.1.1.1", "1.0.0.1"]
}

resource "routeros_ip_dns" "config" {
  allow_remote_requests = true
  servers               = local.upstream_dns_servers
}
