terraform {
  required_version = ">= 0.9.3"
  backend "s3" {
    bucket = "kr.sideeffect.terraform.state"
    key = "vpc/terraform.tfstate"
    region = "ap-northeast-1"
    encrypt = true
    lock_table = "SideEffectTerraformStateLock"
    acl = "bucket-owner-full-control"
  }
}
