terraform {
  required_version = ">= 0.11.1"

  backend "s3" {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "digitalocean/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}
