resource "aws_lightsail_instance" "blog" {
  name              = "blog.outsider.ne.kr"
  availability_zone = data.aws_availability_zones.available.names[0]
  blueprint_id      = "ubuntu_18_04"
  bundle_id         = "medium_2_0"
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
      "sudo apt-get update",
      "sudo apt-get install -y python software-properties-common",
    ]
  }

  provisioner "local-exec" {
    command = <<EOF
      echo "[blog]\n${self.public_ip_address} ansible_connection=ssh ansible_ssh_user=ubuntu" > inventory
      # ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory init.yml
      # ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory letsencrypt.yml
      
EOF

  }
}

