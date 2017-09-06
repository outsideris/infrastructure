resource "aws_ecs_task_definition" "vault" {
  family = "vault"
  container_definitions = "${file("task-definitions/vault.json")}"
  task_role_arn = "${data.terraform_remote_state.global.iam_role_vault_ecs_task_role_arn}"
}

resource "aws_ecs_service" "vault" {
  name = "vault"
  cluster = "${data.terraform_remote_state.vpc.ecs_side_effect_id}"
  task_definition = "${aws_ecs_task_definition.vault.arn}"
  desired_count = 1
  iam_role = "${data.terraform_remote_state.global.iam_role_ecs_service_role_arn}"

  depends_on = [
    "aws_alb_listener.side_effect_https",
  ]

  placement_strategy {
    type = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.vault.arn}"
    container_name = "vault"
    container_port = 8200
  }
}

resource "aws_alb_target_group" "vault" {
  name = "ecs-vault"
  port = 8200
  protocol = "HTTP"
  vpc_id = "${data.terraform_remote_state.vpc.side_effect_id}"
  health_check = {
    path = "/"
  }
}
