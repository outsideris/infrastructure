# create new ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.name}"
}

resource "aws_launch_configuration" "main" {
  name_prefix          = "${var.name}-"
  image_id             = "ami-3a000e5d"    // amzn-ami-2017.03.b-amazon-ecs-optimized
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "ecsInstanceRole"
  key_name             = "${var.keypair}"

  security_groups = ["${var.security_groups}"]

  user_data     = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.main.name} > /etc/ecs/ecs.config"
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

resource "aws_autoscaling_group" "main" {
  name                 = "${var.name}"
  availability_zones   = ["${var.availability_zones}"]
  launch_configuration = "${aws_launch_configuration.main.name}"

  vpc_zone_identifier = ["${var.subnets}"]

  min_size         = "${var.cluster_min_size}"
  max_size         = "${var.cluster_max_size}"
  desired_capacity = "${var.cluster_desired_capacity}"

  tag = [
    {
      key                 = "Name"
      value               = "ecs-${var.name}"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "${var.environment}"
      propagate_at_launch = true
    },
    {
      key                 = "TerraformManaged"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}
