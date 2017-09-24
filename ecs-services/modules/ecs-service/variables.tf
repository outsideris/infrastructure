variable "name" {
  description = "The name to use for the ECS service and all other resources in this module."
}

variable "cluster_id" {
  description = "The id of cluster which the ECS service runs on."
}

variable "desired_count" {
  description = "The count of service to launch for the ECS service."
  default     = 1
}

variable "container_port" {
  description = "The port which the container listen to."
}

variable "vpc_id" {
  description = "The ID of VPC which the ECS service in."
}

variable "health_check_path" {
  description = "The path for health check for the ECS service."
}

variable "task_role_arn" {
  description = "The IAM role for the ECS service."
  default     = ""
}
