variable "node" {
  type        = string
  description = "Name of the node to add a ZFS pool to"
}

variable "id" {
  type        = string
  description = "ID to use for the new storage destination"
}

variable "pool" {
  type        = string
  description = "Name of the ZFS pool to import"
}

variable "content" {
  type = list(string)
  description = "List of content types this storage destination can be used for"
  default = ["images", "rootdir", "vztmpl"]
}

variable "blocksize" {
  type = string
  description = "Size of blocks in newly created volumes"
  default = "16k"
}

variable "thin" {
  type = bool
  description = "Whether to use thin provisioning"
  default = true
}