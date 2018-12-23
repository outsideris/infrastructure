terraform {
  required_version = ">= 0.11.11"

  backend "s3" {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "ap-northeast-2/blog/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}
