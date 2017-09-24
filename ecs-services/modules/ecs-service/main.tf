# create an ecs service
resource "aws_ecs_task_definition" "main" {
  family                = "${var.name}"
  container_definitions = "${file("task-definitions/${var.name}.json")}"
  task_role_arn         = "${var.task_role_arn}"
}

resource "aws_ecs_service" "main" {
  name            = "${var.name}"
  cluster         = "${var.cluster_id}"
  task_definition = "${aws_ecs_task_definition.main.arn}"
  desired_count   = "${var.desired_count}"
  iam_role        = "${data.terraform_remote_state.global.iam_role_ecs_service_role_arn}"

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.main.arn}"
    container_name   = "${var.name}"
    container_port   = "${var.container_port}"
  }
}

resource "aws_alb_target_group" "main" {
  name     = "ecs-${var.name}"
  port     = "${var.container_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check = {
    path = "${var.health_check_path}"
  }
}

# global terraform
data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    bucket     = "kr.sideeffect.terraform.state"
    key        = "global/terraform.tfstate"
    region     = "ap-northeast-1"
    encrypt    = true
    lock_table = "SideEffectTerraformStateLock"
    acl        = "bucket-owner-full-control"
  }
}
