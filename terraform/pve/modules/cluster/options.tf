resource "proxmox_cluster_options" "options" {
  language   = "en"
  keyboard   = "en-gb"
  email_from = var.email_from
}