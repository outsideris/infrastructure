# create new ECS cluster
resource "aws_ecs_cluster" "main" {
  name = var.name
}

resource "aws_launch_configuration" "main" {
  name_prefix          = "${var.name}-"
  image_id             = "ami-086ca990ae37efc1b" // amzn2-ami-ecs-hvm-2.0.20190301-x86_64-ebs
  instance_type        = var.instance_type
  iam_instance_profile = "ecsInstanceRole"
  key_name             = var.keypair

  security_groups = var.security_groups

  user_data     = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.main.name} > /etc/ecs/ecs.config"
  ebs_optimized = false

  root_block_device {
    volume_type           = "standard"
    volume_size           = 30
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name                 = var.name
  launch_configuration = aws_launch_configuration.main.name

  vpc_zone_identifier = var.subnets

  min_size         = var.cluster_min_size
  max_size         = var.cluster_max_size
  desired_capacity = var.cluster_desired_capacity

  tag {
    key                 = "Name"
    value               = "ecs-${var.name}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
  tag {
    key                 = "TerraformManaged"
    value               = "true"
    propagate_at_launch = true
  }
}

