# side-effect VPC for my personal projects
module "side_effect_vpc" {
  source          = "../modules/vpc"
  name            = "sideeffect"
  cidr            = "10.10.0.0/16"
  environment     = "production"
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.10.0/24", "10.10.11.0/24"]
  keypair         = "${var.keypair}"
}
