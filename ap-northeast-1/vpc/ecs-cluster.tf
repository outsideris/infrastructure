# sideeffect ecs cluster
module "side_effect_ecs_cluster" {
  source  = "../modules/ecs-cluster"
  name    = "sideeffect"
  keypair = var.keypair

  security_groups = [
    module.side_effect_vpc.security_group_default,
    module.side_effect_vpc.security_group_ephemeral_ports,
  ]

  subnets                  = module.side_effect_vpc.public_subnets
  cluster_min_size         = 1
  cluster_max_size         = 2
  cluster_desired_capacity = 1
  instance_type            = "t3.micro"
  environment              = "production"
}

