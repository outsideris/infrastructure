terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.19.0"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "ap-northeast-2/blog/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}
