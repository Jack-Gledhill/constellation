output "interface_name" {
  value       = routeros_interface_wireguard.vpn.name
  description = "Name of the interface this subnet runs on"
}

output "interface_public_key" {
  value       = routeros_interface_wireguard.vpn.public_key
  description = "Public key of the new interface"
}

output "interface_port" {
  value       = routeros_interface_wireguard.vpn.listen_port
  description = "Port that the interface runs on"
}

output "subnet" {
  value       = local.subnet
  description = "CIDR notation of this subnet"
}

output "gateway" {
  value       = local.gateway
  description = "IP address of this subnet's gateway"
}
