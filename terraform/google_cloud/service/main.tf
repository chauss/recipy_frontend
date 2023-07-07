terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.29.0"
    }
  }
}

provider "google" {
  project = var.projectId
  region  = "europe-west3"
}

data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "tf-state-recipy"
    prefix = "network"
  }
}

data "terraform_remote_state" "database" {
  backend = "gcs"
  config = {
    bucket = "tf-state-recipy"
    prefix = "database"
  }
}
