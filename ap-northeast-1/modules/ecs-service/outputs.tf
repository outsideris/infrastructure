# The service ID.
output "id" {
  value = aws_ecs_service.main.id
}

# The service name.
output "name" {
  value = aws_ecs_service.main.name
}

# The ARN of cluster which the service runs on.
output "cluster" {
  value = aws_ecs_service.main.cluster
}

# The ARN of IAM role used for ELB
output "iam_role" {
  value = aws_ecs_service.main.iam_role
}

# The number of instances of the task definition
output "desired_count" {
  value = aws_ecs_service.main.desired_count
}

# The ARN of the Target Group
output "target_group_arn" {
  value = aws_alb_target_group.main.arn
}

#  The ARN suffix of the Target Group for use with CloudWatch Metrics.
output "target_group_arn_suffix" {
  value = aws_alb_target_group.main.arn_suffix
}

