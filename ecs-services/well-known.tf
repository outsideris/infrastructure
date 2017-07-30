resource "aws_ecs_task_definition" "well_known" {
  family = "well-known"
  container_definitions = "${file("task-definitions/well-known.json")}"
}

resource "aws_ecs_service" "well_known" {
  name = "well-known"
  cluster = "${data.terraform_remote_state.vpc.ecs_side_effect_id}"
  task_definition = "${aws_ecs_task_definition.well_known.arn}"
  desired_count = 1
  iam_role = "${data.terraform_remote_state.global.iam_role_ecs_service_role_arn}"

  depends_on = [
    "aws_alb_listener.side_effect_http",
    "aws_alb_listener.side_effect_https",
  ]

  placement_strategy {
    type = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.well_known.arn}"
    container_name = "well-known"
    container_port = 80
  }
}

resource "aws_alb_target_group" "well_known" {
  name = "ecs-well-known"
  port = 80
  protocol = "HTTP"
  vpc_id = "${data.terraform_remote_state.vpc.side_effect_id}"
  health_check = {
    path = "/"
  }
}
