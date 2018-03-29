resource "google_storage_bucket" "terraform-state" {
  name     = "kr-sideeffect-terraform-state"
  location = "asia-northeast1"
  versioning = {
    enabled = "true"
  }
}
