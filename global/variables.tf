// ecs-services terraform
data "terraform_remote_state" "ecs_services" {
  backend = "s3"
  config {
    bucket = "kr.sideeffect.terraform.state"
    key = "ecs-services/terraform.tfstate"
    region = "ap-northeast-1"
    encrypt = true
    lock_table = "SideEffectTerraformStateLock"
    acl = "bucket-owner-full-control"
  }
}
