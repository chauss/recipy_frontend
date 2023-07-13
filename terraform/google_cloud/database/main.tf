terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.29.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = local.region
}

data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "tf-state-recipy"
    prefix = "network"
  }
}
