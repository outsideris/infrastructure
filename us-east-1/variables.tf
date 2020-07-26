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
