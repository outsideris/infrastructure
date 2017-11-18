# VPC terraform
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket     = "kr.sideeffect.terraform.state"
    key        = "ap-northeast-1/vpc/terraform.tfstate"
    region     = "ap-northeast-1"
    encrypt    = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl        = "bucket-owner-full-control"
  }
}

# ecs-services terraform
data "terraform_remote_state" "ecs_services" {
  backend = "s3"

  config {
    bucket     = "kr.sideeffect.terraform.state"
    key        = "ap-northeast-1/ecs-services/terraform.tfstate"
    region     = "ap-northeast-1"
    encrypt    = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl        = "bucket-owner-full-control"
  }
}

# us-east-1 terraform
data "terraform_remote_state" "us_east_1" {
  backend = "s3"

  config {
    bucket     = "kr.sideeffect.terraform.state"
    key        = "us-east-1/terraform.tfstate"
    region     = "ap-northeast-1"
    encrypt    = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl        = "bucket-owner-full-control"
  }
}

data "aws_elb_service_account" "main" {}
