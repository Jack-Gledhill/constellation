module "pbs" {
  source = "modules/pbs"

  server = var.pbs_server
  fingerprint = var.pbs_fingerprint
  datastore = var.pbs_datastore
  username = var.pbs_username
  password = var.pbs_password
}

resource "proxmox_backup_job" "daily_backup" {
  id       = "daily-backup"
  comment  = "Backup all LXCs and VMs at midnight"
  schedule = "*-*-* 00:00"
  storage  = module.pbs.storage_id

  all                       = true
  repeat_missed             = true
  mode                      = "suspend"
  compress                  = "zstd"
  notification_mode         = "notification-system"
  notes_template            = "{{vmid}} ({{guestname}})"
  pbs_change_detection_mode = "metadata"

  fleecing = {
    enabled = true
    storage = module.cluster.local_storage_id
  }

  prune_backups = {
    keep-daily   = "7"
    keep-weekly  = "4"
    keep-monthly = "12"
  }
}
