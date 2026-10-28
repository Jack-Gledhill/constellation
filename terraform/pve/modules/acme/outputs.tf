output "issuer_name" {
  description = "Name of the primary issuer account"
  value       = proxmox_acme_account.letsencrypt.name
}

output "dns_plugin_name" {
  description = "Name of the DNS-01 challenge plugin"
  value       = proxmox_acme_dns_plugin.cloudflare.plugin
}