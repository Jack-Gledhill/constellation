variable "server" {
  type        = string
  description = "Address of Proxmox Backup Server to configure as a storage destination"
}

variable "username" {
  type        = string
  description = "Username to use when authenticating to Proxmox Backup Server"
}

variable "password" {
  type        = string
  description = "Password to use when authenticating to Proxmox Backup Server"
  sensitive   = true
}

variable "fingerprint" {
  type        = string
  description = "Fingerprint of the Proxmox Backup Server"
}

variable "datastore" {
  type        = string
  description = "Datastore of the Proxmox Backup Server to use when backing up guests"
}