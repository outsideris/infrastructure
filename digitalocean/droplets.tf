resource "digitalocean_droplet" "blog" {
  image      = "ubuntu-17-04-x64"
  name       = "blog"
  region     = "sgp1"
  size       = "2gb"
  monitoring = true
  ipv6       = true
  ssh_keys   = ["5c:62:af:d8:28:72:d7:36:eb:29:47:ec:7d:90:8d:28"]
}
