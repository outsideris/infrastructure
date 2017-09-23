# The ALB listener rule ID.
output "id" {
  value = "${aws_alb_listener_rule.main.id}"
}

# The ALB listener rule ARN.
output "arn" {
  value = "${aws_alb_listener_rule.main.arn}"
}
