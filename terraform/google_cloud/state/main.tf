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
}

resource "google_storage_bucket" "state_bucket" {
  project                     = var.projectId
  name                        = "tf-state-recipy"
  location                    = "EU"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
