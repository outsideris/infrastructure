resource "aws_instance" "teslamate" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.xlarge"

  subnet_id = data.terraform_remote_state.vpc.outputs.side_effect_public_subnets[0]

  vpc_security_group_ids = [
    data.terraform_remote_state.vpc.outputs.side_effect_default_sg,
    data.terraform_remote_state.vpc.outputs.side_effect_ephemeral_ports_sg,
    data.terraform_remote_state.vpc.outputs.side_effect_bastion_sg,
    data.terraform_remote_state.vpc.outputs.side_effect_public_web_sg,
  ]

  key_name = var.keypair

  tags = {
    Name = "teslamate"
  }

  connection {
    user = "ubuntu"
    type = "ssh"
    host = self.public_ip
    private_key = file(var.keypair_private)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y apt-transport-https ca-certificates curl python software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      // install docker
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
      echo "[teslamate]\n${self.public_ip} ansible_connection=ssh ansible_ssh_user=ubuntu ansible_ssh_private_key_file=${var.keypair_private}" > inventory
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory teslamate.yml
    EOF
  }
}
