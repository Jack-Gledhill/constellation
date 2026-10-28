variable "nodes" {
  type        = list(string)
  description = "List of the names of each node"
}

variable "email_from" {
  type        = string
  description = "Email address to use when sending notifications"
}

variable "dns_domain" {
  type        = string
  description = "Top-level domain name to use in DNS settings"
}

variable "time_zone" {
  type = string
  description = "Time zone to use for NTP settings"
  default = "Europe/London"
}

variable "apt_repositories" {
  type = map(bool)
  description = "Map of Proxmox's standard APT repositories indicating whether each is enabled or not"
  default = {
    no-subscription = true
    enterprise = false
    test = false
    ceph-squid-no-subscription = false
    ceph-squid-enterprise = false
    ceph-squid-test = false
  }
}