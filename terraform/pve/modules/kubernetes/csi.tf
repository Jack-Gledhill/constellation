resource "proxmox_virtual_environment_role" "csi" {
  role_id = "KubernetesCSI"

  privileges = [
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.Audit",
    "VM.Audit",
    "VM.Config.Disk"
  ]
}

resource "proxmox_user_token" "csi" {
  token_name            = "csi"
  user_id               = proxmox_virtual_environment_user.kubernetes.user_id
  comment               = "API token for proxmox-csi-plugin"
  privileges_separation = true
}

resource "proxmox_acl" "csi" {
  token_id = proxmox_user_token.csi.id
  role_id  = proxmox_virtual_environment_role.csi.role_id

  path      = "/pool/" + proxmox_virtual_environment_pool.kubernetes.id
  propagate = false
}
