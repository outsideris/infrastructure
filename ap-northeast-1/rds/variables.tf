variable "teslamate_db_password" {
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
