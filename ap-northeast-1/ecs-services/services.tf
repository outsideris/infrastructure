module "ecs_service_popular_convention" {
  source        = "../modules/ecs-service"
  name          = "popular-convention"
  cluster_id    = "${data.terraform_remote_state.vpc.ecs_side_effect_id}"
  desired_count = 1

  container_port    = 8020
  vpc_id            = "${data.terraform_remote_state.vpc.side_effect_id}"
  health_check_path = "/popularconvention"
}

module "ecs_service_well_known" {
  source        = "../modules/ecs-service"
  name          = "well-known"
  cluster_id    = "${data.terraform_remote_state.vpc.ecs_side_effect_id}"
  desired_count = 1

  container_port    = 80
  vpc_id            = "${data.terraform_remote_state.vpc.side_effect_id}"
  health_check_path = "/"
}

module "ecs_service_vault" {
  source        = "../modules/ecs-service"
  name          = "vault"
  task_role_arn = "${data.terraform_remote_state.global.iam_role_vault_ecs_task_role_arn}"
  cluster_id    = "${data.terraform_remote_state.vpc.ecs_side_effect_id}"
  desired_count = 1

  container_port    = 8200
  vpc_id            = "${data.terraform_remote_state.vpc.side_effect_id}"
  health_check_path = "/"
}
