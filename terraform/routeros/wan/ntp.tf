locals {
  upstream_ntp_servers = ["0.debian.pool.ntp.org", "1.debian.pool.ntp.org"]
}

resource "routeros_system_ntp_client" "debian" {
  enabled = true
  mode    = "unicast"
  servers = local.upstream_ntp_servers
}
