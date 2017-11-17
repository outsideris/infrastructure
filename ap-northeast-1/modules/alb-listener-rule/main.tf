# add a listener rule into a given alb listener 
resource "aws_alb_listener_rule" "main" {
  listener_arn = "${var.listener_arn}"
  priority     = "${var.priority}"

  action {
    type             = "forward"
    target_group_arn = "${var.target_group_arn}"
  }

  condition {
    field  = "${var.condition_field}"
    values = ["${var.condition_values}"]
  }
}
