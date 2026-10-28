resource "proxmox_apt_standard_repository" "no_subscription" {
  handle = "no-subscription"
  node   = var.node
}

resource "proxmox_apt_repository" "no_subscription" {
  enabled   = true
  file_path = proxmox_apt_standard_repository.no_subscription.file_path
  index     = proxmox_apt_standard_repository.no_subscription.index
  node      = proxmox_apt_standard_repository.no_subscription.node
}

resource "proxmox_apt_standard_repository" "enterprise" {
  handle = "enterprise"
  node   = var.node
}

resource "proxmox_apt_repository" "enterprise" {
  enabled   = false
  file_path = proxmox_apt_standard_repository.enterprise.file_path
  index     = proxmox_apt_standard_repository.enterprise.index
  node      = proxmox_apt_standard_repository.enterprise.node
}

resource "proxmox_apt_standard_repository" "test" {
  handle = "test"
  node   = var.node
}

resource "proxmox_apt_repository" "test" {
  enabled   = false
  file_path = proxmox_apt_standard_repository.test.file_path
  index     = proxmox_apt_standard_repository.test.index
  node      = proxmox_apt_standard_repository.test.node
}

resource "proxmox_apt_standard_repository" "ceph_squid_no_subscription" {
  handle = "ceph-squid-no-subscription"
  node   = var.node
}

resource "proxmox_apt_repository" "ceph_squid_no_subscription" {
  enabled   = false
  file_path = proxmox_apt_standard_repository.ceph_squid_no_subscription.file_path
  index     = proxmox_apt_standard_repository.ceph_squid_no_subscription.index
  node      = proxmox_apt_standard_repository.ceph_squid_no_subscription.node
}

resource "proxmox_apt_standard_repository" "ceph_squid_enterprise" {
  handle = "ceph-squid-enterprise"
  node   = var.node
}

resource "proxmox_apt_repository" "ceph_squid_ceph_squid_enterprise" {
  enabled   = false
  file_path = proxmox_apt_standard_repository.ceph_squid_enterprise.file_path
  index     = proxmox_apt_standard_repository.ceph_squid_enterprise.index
  node      = proxmox_apt_standard_repository.ceph_squid_enterprise.node
}

resource "proxmox_apt_standard_repository" "ceph_squid_test" {
  handle = "ceph-squid-test"
  node   = var.node
}

resource "proxmox_apt_repository" "ceph_squid_ceph_squid_test" {
  enabled   = false
  file_path = proxmox_apt_standard_repository.ceph_squid_test.file_path
  index     = proxmox_apt_standard_repository.ceph_squid_test.index
  node      = proxmox_apt_standard_repository.ceph_squid_test.node
}
