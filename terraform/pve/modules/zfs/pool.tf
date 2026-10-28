resource "proxmox_storage_zfspool" "zfs" {
  id    = var.id
  nodes = [var.node]

  zfs_pool       = var.pool
  content        = var.content
  blocksize      = var.blocksize
  thin_provision = var.thin
}