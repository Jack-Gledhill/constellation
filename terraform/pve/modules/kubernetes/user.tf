resource "proxmox_virtual_environment_user" "kubernetes" {
  user_id  = var.username
  password = var.password
  comment  = "Service account for the Kubernetes cluster"
}
