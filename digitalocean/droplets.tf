resource "digitalocean_droplet" "teslamate" {
  image      = "ubuntu-20-04-x64"
  name       = "teslamate"
  region     = "sfo2"
  size       = "s-1vcpu-1gb"
  monitoring = true
  ipv6       = true
  ssh_keys = [16738]

  connection {
    user     = "root"
    type     = "ssh"
    host     = self.ipv4_address
    private_key = file(var.digitalocean_private_key)
    timeout  = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      // install dependencies
      "sudo apt update",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "sudo apt update",
      "sudo apt install -y python3-pip",
      // install docker
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable\"",
      "sudo apt update",
      "apt-cache policy docker-ce",
      "sudo apt install -y docker-ce",
      "sudo systemctl status docker --no-pager",
      "sudo usermod -aG docker $USER",
      "docker -v",
      // install docker-compose
      "sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "docker-compose --version"
    ]
  }

  provisioner "local-exec" {
    command = <<EOF
      echo "[teslamate]\n${self.ipv4_address} ansible_connection=ssh ansible_ssh_user=root ansible_ssh_private_key_file=${var.digitalocean_private_key}" > teslamate/inventory
      # ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i teslamate/inventory teslamate/installation.yml
    EOF
  }
}
