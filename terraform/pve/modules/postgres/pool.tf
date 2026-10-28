resource "proxmox_virtual_environment_pool" "postgres" {
  pool_id = "postgres"
  comment = "PostgreSQL database servers"
}
