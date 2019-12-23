terraform {
  required_version = ">= 0.12.18"

  backend "s3" {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "ap-northeast-1/rds/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}

