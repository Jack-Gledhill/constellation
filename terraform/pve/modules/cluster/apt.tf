locals {
  std_repositories = flatten([
    for n in var.nodes: [
      for r in var.apt_repositories: {
        node = n
        handle = r
      }
    ]
  ])
}

data "proxmox_apt_standard_repository" "repositories" {
  for_each = local.std_repositories
  node   = each.value.node
  handle = each.value.handle
}

resource "proxmox_apt_repository" "std_repositories" {
  for_each = proxmox_apt_standard_repository.repositories
  node      = each.value.node
  file_path = each.value.file_path
  index     = each.value.index

  enabled = lookup(var.apt_repositories, each.value.handle, true)
}