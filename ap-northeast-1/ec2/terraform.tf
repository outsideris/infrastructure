terraform {
  required_version = ">= 0.10.5"

  backend "s3" {
    bucket     = "kr.sideeffect.terraform.state"
    key        = "ap-northeast-1/ec2/terraform.tfstate"
    region     = "ap-northeast-1"
    encrypt    = true
    lock_table = "SideEffectTerraformStateLock"
    acl        = "bucket-owner-full-control"
  }
}
