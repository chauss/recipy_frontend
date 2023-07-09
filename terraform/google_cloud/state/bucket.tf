resource "google_storage_bucket" "state_bucket" {
  name                        = "tf-state-recipy"
  location                    = "EU"
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  force_destroy = true
}
