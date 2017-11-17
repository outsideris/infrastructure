output "name" {
  value = "${aws_alb.main.name}"
}

# The ALB ID.
output "id" {
  value = "${aws_alb.main.id}"
}

# The ALB ARN.
output "arn" {
  value = "${aws_alb.main.arn}"
}

# The ALB dns_name.
output "dns" {
  value = "${aws_alb.main.dns_name}"
}

# The zone id of the ALB
output "zone_id" {
  value = "${aws_alb.main.zone_id}"
}
