# sideeffect ecs cluster
resource "aws_ecs_cluster" "sideeffect" {
  name = "sideeffect"
}

resource "aws_launch_configuration" "sideeffect" {
  name_prefix          = "sideeffect-"
  image_id             = "ami-3a000e5d"    // amzn-ami-2017.03.b-amazon-ecs-optimized
  instance_type        = "t2.micro"
  iam_instance_profile = "ecsInstanceRole"
  key_name             = "${var.keypair}"

  security_groups = [
    "${module.side_effect_vpc.security_group_default}",
    "${module.side_effect_vpc.security_group_ephemeral_ports}",
  ]

  user_data     = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.sideeffect.name} > /etc/ecs/ecs.config"
  ebs_optimized = false

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 80
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "sideeffect" {
  name                 = "sideeffect"
  availability_zones   = ["${module.side_effect_vpc.availability_zones}"]
  launch_configuration = "${aws_launch_configuration.sideeffect.name}"

  vpc_zone_identifier = ["${module.side_effect_vpc.private_subnets}"]

  min_size         = 1
  max_size         = 4
  desired_capacity = 3

  tag = [
    {
      key                 = "Name"
      value               = "ecs-sideeffect"
      propagate_at_launch = true
    },
  ]
}
