# sideeffect ecs cluster
module "side_effect_ecs_cluster" {
  source  = "../modules/ecs-cluster"
  name    = "sideeffect"
  keypair = "${var.keypair}"

  security_groups = [
    "${module.side_effect_vpc.security_group_default}",
    "${module.side_effect_vpc.security_group_ephemeral_ports}",
  ]

  availability_zones       = ["${module.side_effect_vpc.availability_zones}"]
  subnets                  = ["${module.side_effect_vpc.public_subnets}"]
  cluster_min_size         = 1
  cluster_max_size         = 1
  cluster_desired_capacity = 1
  instance_type            = "t2.micro"
  environment              = "production"
}
