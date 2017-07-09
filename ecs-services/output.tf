output "side_effect_alb_dns" {
  value = "${aws_alb.side_effect.dns_name}"
}

output "side_effect_alb_zone_id" {
  value = "${aws_alb.side_effect.zone_id}"
}
