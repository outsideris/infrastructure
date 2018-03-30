resource "google_container_cluster" "k8s_study" {
  name               = "k8s-study"
  zone               = "${data.google_compute_zones.available.names[0]}"
  initial_node_count = 2

  node_version       = "1.9.4"
  min_master_version = "1.9.4"

  additional_zones = [
    "${data.google_compute_zones.available.names[1]}",
  ]

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
