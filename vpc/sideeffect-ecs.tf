# sideeffect ecs cluster
resource "aws_ecs_cluster" "sideeffect" {
  name = "sideeffect"
}

resource "aws_launch_configuration" "sideeffect" {
  name_prefix = "sideeffect-"
  image_id = "ami-3a000e5d" // amzn-ami-2017.03.b-amazon-ecs-optimized
  instance_type = "t2.micro"
  iam_instance_profile = "ecsInstanceRole"
  key_name = "${var.keypair}"
  security_groups = [
    "${aws_default_security_group.side_effect_default.id}",
    "${aws_security_group.sideeffect_ephemeral_ports.id}",
  ]
  user_data = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.sideeffect.name} > /etc/ecs/ecs.config"
  ebs_optimized = false

  root_block_device {
    volume_type = "gp2"
    volume_size = 80
    delete_on_termination = true
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_autoscaling_group" "sideeffect" {
  name = "sideeffect"
  availability_zones = ["${data.aws_availability_zones.available.names}"]
  launch_configuration = "${aws_launch_configuration.sideeffect.name}"
  vpc_zone_identifier = [
    "${aws_subnet.side_effect_private_subnet1.id}",
    "${aws_subnet.side_effect_private_subnet2.id}"
  ]
  min_size = 1
  max_size = 3
  desired_capacity = 2

  tag = [
    {
      key = "Name"
      value = "ecs-sideeffect"
      propagate_at_launch = true
    }
  ]
}
