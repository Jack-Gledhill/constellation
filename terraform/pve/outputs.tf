output "kubernetes_csi_user_token" {
  description = "API token for proxmox-csi-plugin"
  value       = module.kubernetes.csi_token
  sensitive   = true
}

output "kubernetes_password" {
  description = "Password generated for the Kubernetes service account"
  value       = random_password.kubernetes_password.result
  sensitive   = true
}