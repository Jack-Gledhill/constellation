resource "proxmox_virtual_environment_pool" "kubernetes" {
  pool_id = "kubernetes"
  comment = "Control plane and worker nodes in the Kubernetes cluster"
}
