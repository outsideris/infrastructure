output "side_effect_id" {
  value = "${module.side_effect_vpc.id}"
}

output "side_effect_public_subnets" {
  value = ["${module.side_effect_vpc.public_subnets}"]
}

output "side_effect_private_subnets" {
  value = ["${module.side_effect_vpc.private_subnets}"]
}

output "side_effect_default_sg" {
  value = "${module.side_effect_vpc.security_group_default}"
}

output "side_effect_ephemeral_ports_sg" {
  value = "${module.side_effect_vpc.security_group_ephemeral_ports}"
}

output "side_effect_bastion_sg" {
  value = "${module.side_effect_vpc.security_group_bastion}"
}

output "side_effect_public_web_sg" {
  value = "${module.side_effect_vpc.security_group_public_web}"
}

output "ecs_side_effect_id" {
  value = "${module.side_effect_ecs_cluster.id}"
}

output "sns_topic_config_service_arn" {
  value = "${aws_sns_topic.config_service.arn}"
}
