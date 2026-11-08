output "interface_name" {
  value       = routeros_interface_bridge.pve.name
  description = "Name of the interface this subnet runs on"
}

output "nodes_subnet" {
  value       = local.nodes_subnet
  description = "CIDR notation of the nodes' subnet"
}

output "nodes_gateway" {
  value       = cidrhost(local.nodes_subnet, 1)
  description = "IP address of the nodes' subnet's gateway"
}

output "guests_subnet" {
  value       = local.guests_subnet
  description = "CIDR notation of the guests' subnet"
}

output "guests_gateway" {
  value       = cidrhost(local.guests_subnet, 1)
  description = "IP address of the guests' subnet's gateway"
}
