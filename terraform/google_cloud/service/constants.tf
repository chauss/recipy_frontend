locals {
  region                = "europe-west3"
  image_data_path       = "/data"
  image_name            = "chauss/recipy-backend:alpha-0.0.1"
  active_spring_profile = "google-cloud"

  sa_roles = [
    "roles/cloudsql.editor",
    "roles/compute.networkUser",
  ]
}
