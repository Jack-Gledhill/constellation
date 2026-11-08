terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}

resource "routeros_system_clock" "constellation" {
  time_zone_name = "Europe/London"
}

resource "routeros_system_identity" "constellation" {
  name = "Constellation"
}

resource "routeros_system_routerboard_settings" "constellation" {
  auto_upgrade = true
  silent_boot  = true
}
