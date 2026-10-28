module "postgres" {
  source = "modules/postgres"
}

resource "random_password" "kubernetes_password" {
  length = 32
  special = true
}

module "kubernetes" {
  source   = "modules/kubernetes"

  username = "kubernetes"
  password = random_password.kubernetes_password.result
}
