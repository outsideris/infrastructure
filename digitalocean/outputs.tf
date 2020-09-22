output "teslamate_ip" {
  description = "The IP address of teslamate instance"
  value       = digitalocean_droplet.teslamate.ipv4_address
}
