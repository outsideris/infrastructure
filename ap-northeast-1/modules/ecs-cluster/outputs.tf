# The Amazon Resource Name (ARN) that identifies the cluster
output "id" {
  value = aws_ecs_cluster.main.id
}

# The name of the cluster
output "name" {
  value = aws_ecs_cluster.main.name
}

# The ID of the launch configuration.
output "launch_configuration_id" {
  value = aws_launch_configuration.main.id
}

# The name of the launch configuration.
output "launch_configuration_name" {
  value = aws_launch_configuration.main.name
}

# The autoscaling group id.
output "autoscaling_group_id" {
  value = aws_autoscaling_group.main.id
}

# The ARN for this AutoScaling Group
output "autoscaling_group_arn" {
  value = aws_autoscaling_group.main.arn
}

# The availability zones of the autoscale group.
output "autoscaling_group_availability_zones" {
  value = aws_autoscaling_group.main.availability_zones
}

# The minimum size of the autoscale group
output "autoscaling_group_min_size" {
  value = aws_autoscaling_group.main.min_size
}

# The maximum size of the autoscale group
output "autoscaling_group_max_size" {
  value = aws_autoscaling_group.main.max_size
}

# The number of Amazon EC2 instances that should be running in the group.
output "autoscaling_group_desired_capacity" {
  value = aws_autoscaling_group.main.desired_capacity
}

