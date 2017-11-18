// my key pair
variable "keypair" {
  default = "outsider-aws"
}

// availability zones
data "aws_availability_zones" "available" {}

// latest ubuntu ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

// latest my own ami
data "aws_ami" "outsider" {
  most_recent = true

  filter {
    name   = "name"
    values = ["outsider-aws-ubuntu*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["410655858509"] # me
}

// global terraform
data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    bucket     = "kr.sideeffect.terraform.state"
    key        = "global/terraform.tfstate"
    region     = "ap-northeast-1"
    encrypt    = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl        = "bucket-owner-full-control"
  }
}
