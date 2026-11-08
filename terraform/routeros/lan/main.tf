terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}

resource "routeros_ipv6_settings" "config" {
  disable_ipv6 = true
}
