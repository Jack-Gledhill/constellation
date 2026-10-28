output "csi_token" {
  description = "API token for proxmox-csi-plugin"
  value       = proxmox_user_token.csi.value
  sensitive   = true
}
