resource "digitalocean_droplet" "blog" {
  image      = "ubuntu-17-04-x64"
  name       = "blog"
  region     = "sgp1"
  size       = "2gb"
  monitoring = true
  ipv6       = true
  ssh_keys   = ["5c:62:af:d8:28:72:d7:36:eb:29:47:ec:7d:90:8d:28"]

  connection {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.digitalocean_private_key)}"
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "adduser --disabled-password --gecos '' ${var.digitalocean_username}",
      "echo ${var.digitalocean_username}:${var.digitalocean_password} | chpasswd",
      "echo '${var.digitalocean_username} ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo",
      "mkdir /home/${var.digitalocean_username}/.ssh",
      "chown ${var.digitalocean_username}:${var.digitalocean_username} /home/${var.digitalocean_username}/.ssh",
      "echo '${file(var.digitalocean_public_key)}' > /home/${var.digitalocean_username}/.ssh/authorized_keys",
    ]
  }
}
