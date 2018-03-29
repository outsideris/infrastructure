terraform {
  required_version = ">= 0.10.5"

  backend "gcs" {
    bucket     = "kr-sideeffect-terraform-state"
    prefix      = "k8s-study"
   region      = "asia-northeast1"
  }
}
