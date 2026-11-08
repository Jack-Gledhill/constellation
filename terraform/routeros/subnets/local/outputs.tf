output "interface_name" {
  value       = routeros_interface_bridge.local.name
  description = "Name of the interface this subnet runs on"
}

output "subnet" {
  value       = local.subnet
  description = "CIDR notation of this subnet"
}

output "gateway" {
  value       = cidrhost(local.subnet, 1)
  description = "IP address of this subnet's gateway"
}
