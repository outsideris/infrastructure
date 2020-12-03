terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.2.0"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    bucket         = "kr.sideeffect.terraform.state"
    key            = "digitalocean/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "SideEffectTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}
