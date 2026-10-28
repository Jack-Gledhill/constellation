resource "proxmox_storage_directory" "local" {
  id = "local"

  path          = "/var/lib/vz"
  content       = ["images", "import", "iso", "rootdir", "snippets", "vztmpl"]
  preallocation = "metadata"
}

resource "proxmox_storage_zfspool" "zfs" {
  id    = "pool"
  nodes = ["sagittarius"]

  zfs_pool       = "pool"
  content        = ["images", "rootdir", "vztmpl"]
  blocksize      = "16k"
  thin_provision = true
}
