provider "google" {
  version     = "~> 1.12"
  credentials = "${file("credentials.json")}"
  project     = "kubernetes-practice-204905"
  region      = "asia-northeast1"
}
