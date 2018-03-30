resource "google_storage_bucket" "terraform_state" {
  name     = "kr-sideeffect-terraform-state"
  location = "asia-northeast1"

  versioning = {
    enabled = "true"
  }
}
