terraform {
  required_version = ">= 1.11.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.118.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.pve_endpoint
  api_token = var.pve_api_token
  insecure  = var.pve_insecure
}

resource "proxmox_cluster_options" "options" {
  language   = "en"
  keyboard   = "en-gb"
  email_from = "noreply@starsystem.dev"
}

module "sagittarius" {
  source = "modules/node"
  node   = "sagittarius"

  acme_account = proxmox_acme_account.letsencrypt
  acme_plugin  = proxmox_acme_dns_plugin.cloudflare
}

module "postgres" {
  source = "modules/postgres"
}

module "kubernetes" {
  source   = "modules/kubernetes"
  username = var.kubernetes_username
  password = var.kubernetes_password
}
