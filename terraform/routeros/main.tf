terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}

provider "routeros" {
  hosturl  = "http://10.0.0.1:8728"
  username = var.ros_username
  password = var.ros_password
}

locals {
  domain = "starsystem.dev"
}

module "firewall" {
  source = "firewall"

  lan_interface_list = routeros_interface_list.lan.name
  wan_interface_list = routeros_interface_list.wan.name
  wg_interface       = module.vpn.interface_name
  wg_port            = module.vpn.interface_port
}

module "system" {
  depends_on = [module.firewall]
  source     = "system"

  trusted_subnets = [module.local.subnet, module.vpn.subnet]
  smtp_from       = "noreply@" + local.domain
  smtp_username   = var.smtp_username
  smtp_password   = var.smtp_password
}
