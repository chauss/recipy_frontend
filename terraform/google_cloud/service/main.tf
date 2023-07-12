terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.29.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
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

data "terraform_remote_state" "database" {
  backend = "gcs"
  config = {
    bucket = "tf-state-recipy"
    prefix = "database"
  }
}

data "terraform_remote_state" "postgres" {
  backend = "gcs"
  config = {
    bucket = "tf-state-recipy"
    prefix = "postgres"
  }
}
