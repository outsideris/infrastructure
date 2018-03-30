provider "google" {
  version     = "~> 1.8"
  credentials = "${file("credentials.json")}"
  project     = "k8s-study-199513"
  region      = "asia-northeast1"
}
