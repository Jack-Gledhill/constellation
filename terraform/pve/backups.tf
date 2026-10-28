resource "proxmox_storage_pbs" "pbs" {
  id = "scorpio"

  server      = var.pbs_server
  fingerprint = var.pbs_fingerprint
  username    = var.pbs_username
  password    = var.pbs_password

  content                 = ["backup"]
  datastore               = "sagittarius"
  generate_encryption_key = true

  backups {
    keep_all = true
  }
}

resource "proxmox_backup_job" "daily_backup" {
  id       = "daily-backup"
  comment  = "Backup all LXCs and VMs at midnight"
  schedule = "*-*-* 00:00"
  storage  = proxmox_storage_pbs.pbs.id

  all                       = true
  repeat_missed             = true
  mode                      = "suspend"
  compress                  = "zstd"
  notification_mode         = "notification-system"
  notes_template            = "{{vmid}} ({{guestname}})"
  pbs_change_detection_mode = "metadata"

  fleecing = {
    enabled = true
    storage = proxmox_storage_directory.local.id
  }

  prune_backups = {
    keep-daily   = "7"
    keep-weekly  = "4"
    keep-monthly = "12"
  }
}
