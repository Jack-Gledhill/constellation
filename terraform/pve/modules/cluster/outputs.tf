output "local_storage_id" {
  description = "ID of the global local storage destination"
  value       = proxmox_storage_directory.local.id
}