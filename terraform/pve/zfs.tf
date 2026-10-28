locals {
  zfs_pools = [{
    node = "sagittarius"
    id = "pool"
    pool = "pool"
  }]
}

module "zfs" {
  for_each = local.zfs_pools
  source = "modules/zfs"

  node = each.value.node
  id = each.value.id
  pool = each.value.pool
}