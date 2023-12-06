resource "aws_lightsail_instance" "blog_2023_2" {
  name              = "my-blog-2023-2"
  availability_zone = data.aws_availability_zones.available.names[0]
  blueprint_id      = "ubuntu_22_04"
  bundle_id         = "large_3_0"
  key_pair_name     = "id_rsa"

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file(var.lightsail_private_key)
    host        = self.public_ip_address
    timeout     = "1m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y software-properties-common",
    ]
  }

  provisioner "local-exec" {
    command = <<EOF
      echo "[blog]\n${self.public_ip_address} ansible_connection=ssh ansible_ssh_user=ubuntu" > inventory
      # ansible-playbook -i inventory init.yml
      # ansible-playbook -i inventory letsencrypt.yml
EOF
  }
}
