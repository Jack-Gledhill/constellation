output "storage_id" {
  description = "ID of the global pbs storage destination"
  value       = proxmox_storage_pbs.pbs.id
}

output "encryption_key" {
  description = "Generated encryption key used to encrypt backups"
  value       = proxmox_storage_pbs.pbs.generated_encryption_key
  sensitive   = true
}

output "encryption_key_fingerprint" {
  description = "Fingerprint of the encryption key currently in use"
  value       = proxmox_storage_pbs.pbs.encryption_key_fingerprint
}
