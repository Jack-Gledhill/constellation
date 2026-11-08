variable "lan_interface_list" {
  type        = string
  description = "Name of the interface list containing all LAN interfaces"
}

variable "wan_interface_list" {
  type        = string
  description = "Name of the interface list containing all WAN interfaces"
}

variable "wg_interface" {
  type        = string
  description = "Interface of the Wireguard subnet"
}

variable "wg_port" {
  type        = string
  description = "External port for the Wireguard server"
}
