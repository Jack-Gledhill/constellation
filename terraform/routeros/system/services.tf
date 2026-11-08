locals {
  services = [
    {
      name     = "www"
      port     = 80
      disabled = false
    },
    {
      name     = "www-ssl"
      port     = 443
      disabled = true
    },
    {
      name     = "api"
      port     = 8728
      disabled = false
    },
    {
      name     = "api-ssl"
      port     = 8279
      disabled = true
    },
    {
      name     = "ftp"
      port     = 21
      disabled = true
    },
    {
      name     = "ssh"
      port     = 22
      disabled = true
    },
    {
      name     = "telnet"
      port     = 23
      disabled = true
    },
    {
      name     = "winbox"
      port     = 8291
      disabled = false
    }
  ]
}

resource "routeros_ip_service" "management" {
  for_each = local.services

  numbers  = each.value.name
  port     = each.value.port
  disabled = each.value.disabled
  address  = join(",", var.trusted_subnets)
}

resource "routeros_ip_smb" "config" {
  enabled    = "no"
  domain     = "CONSTELLATION"
  interfaces = "none"
}

resource "routeros_ip_ssh_server" "config" {
  allow_none_crypto           = false
  always_allow_password_login = false
  strong_crypto               = true
  forwarding_enabled          = "no"
  host_key_size               = 4096
  host_key_type               = "RSA"
}
