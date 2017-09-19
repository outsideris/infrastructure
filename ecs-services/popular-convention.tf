resource "aws_ecs_task_definition" "popular_convention" {
  family                = "popular-convention"
  container_definitions = "${file("task-definitions/popular-convention.json")}"
}

resource "aws_ecs_service" "popular_convention" {
  name            = "popular-convention"
  cluster         = "${data.terraform_remote_state.vpc.ecs_side_effect_id}"
  task_definition = "${aws_ecs_task_definition.popular_convention.arn}"
  desired_count   = 1
  iam_role        = "${data.terraform_remote_state.global.iam_role_ecs_service_role_arn}"

  depends_on = [
    "aws_alb_listener.side_effect_http",
    "aws_alb_listener.side_effect_https",
  ]

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
    container_name   = "popular-convention"
    container_port   = 8020
  }
}

resource "aws_alb_target_group" "popular_convention" {
  name     = "ecs-popular-convention"
  port     = 8020
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.vpc.side_effect_id}"

  health_check = {
    path = "/popularconvention"
  }
}
