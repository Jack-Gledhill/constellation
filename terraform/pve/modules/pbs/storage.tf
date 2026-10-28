resource "proxmox_storage_pbs" "pbs" {
  id = "pbs"

  server      = var.server
  fingerprint = var.fingerprint
  username    = var.username
  password    = var.password

  content                 = ["backup"]
  datastore               = var.pbs_datastore
  generate_encryption_key = true

  backups {
    keep_all = true
  }
}