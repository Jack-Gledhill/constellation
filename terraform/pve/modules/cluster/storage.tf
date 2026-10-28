resource "proxmox_storage_directory" "local" {
  id = "local"
  nodes = var.nodes

  path          = "/var/lib/vz"
  content       = ["images", "import", "iso", "rootdir", "snippets", "vztmpl"]
  preallocation = "metadata"
}