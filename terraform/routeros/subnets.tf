module "kvm" {
  source = "subnets/kvm"
}

module "local" {
  source = "subnets/local"
}

module "pve" {
  source = "subnets/pve"
}

module "vpn" {
  source        = "subnets/vpn"
  preshared_key = var.wg_preshared_key
  private_key   = var.wg_private_key
}
