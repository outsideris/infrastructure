output "side_effect_id" {
  value = "${aws_vpc.side_effect.id}"
}

output "side_effect_public_subnets" {
  value = [
    "${aws_subnet.side_effect_public_subnet1.id}"
  ]
}

output "side_effect_private_subnets" {
  value = [
    "${aws_subnet.side_effect_private_subnet1.id}",
    "${aws_subnet.side_effect_private_subnet2.id}"
  ]
}

output "side_effect_default_sg" {
  value = "${aws_default_security_group.side_effect_default.id}"
}

output "side_effect_bastion_sg" {
  value = "${aws_security_group.side_effect_bastion.id}"
}