terraform {
  required_version = ">= 1.11.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.118.0"
    }
  }
}

locals {
  domain = "starsystem.dev"
  nodes = ["sagittarius"]
}

provider "proxmox" {
  endpoint  = local.nodes[0] + "." + local.domain
  api_token = var.pve_api_token
}

module "cluster" {
  source = "modules/cluster"

  nodes   = local.nodes
  email_from = "noreply@" + local.domain
  dns_domain = local.domain
}

module "acme" {
  source = "modules/acme"

  email = "admin@" + local.domain
  certificates = [for n in local.nodes: { node = n, domain = n + "." + local.domain }]
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_token = var.cloudflare_token
}