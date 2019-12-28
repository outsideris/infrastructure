// availability zones
data "aws_availability_zones" "available" {
}

// global terraform
data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "global/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}

// vpc terraform
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "ap-northeast-1/vpc/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}

// rds terraform
data "terraform_remote_state" "rds" {
  backend = "s3"

  config = {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "ap-northeast-1/rds/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}

// my key pair
variable "keypair" {
  default = "outsider-aws"
}

variable "keypair_private" {
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}
