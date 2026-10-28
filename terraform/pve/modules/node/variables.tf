variable "node" {
  type        = string
  description = "Name of the node to configure"
}

variable "acme_account" {
  type = object({
    name = string
  })
  description = "The ACME account to use to generate a certificate for the node"
}

variable "acme_plugin" {
  type = object({
    plugin = string
  })
  description = "The ACME challenge plugin to use to generate a certificate for the node"
}
