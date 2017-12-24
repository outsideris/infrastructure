provider "digitalocean" {
  version = "~> 0.1"
  token   = "${var.digitalocean_token}"
}
