# The ALB listener ID.
output "id" {
  value = "${aws_alb_listener.main.id}"
}

# The ALB listener ARN.
output "arn" {
  value = "${aws_alb_listener.main.arn}"
}
