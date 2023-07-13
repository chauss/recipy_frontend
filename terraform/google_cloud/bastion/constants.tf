locals {
  region           = "europe-west3"
  bastion_host_tag = "bastion-host"

  sa_roles = [
    "roles/cloudsql.client",
  ]
}
