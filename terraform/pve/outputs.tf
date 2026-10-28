output "kubernetes_csi_user_token" {
  description = "API token for proxmox-csi-plugin"
  value       = module.kubernetes.csi_token
  sensitive   = true
}
