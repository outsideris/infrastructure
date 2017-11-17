# create a listener for application load balancer
resource "aws_alb_listener" "main" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "${var.port}"
  protocol          = "${var.protocol}"

  ssl_policy      = "${var.protocol == "HTTPS" ? "ELBSecurityPolicy-2016-08" : ""}"
  certificate_arn = "${var.protocol == "HTTPS" ? var.certificate_arn : ""}"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}
