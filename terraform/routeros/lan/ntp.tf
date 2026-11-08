resource "routeros_system_ntp_server" "lan" {
  enabled         = true
  broadcast       = true
  multicast       = true
  manycast        = true
  use_local_clock = true
}
