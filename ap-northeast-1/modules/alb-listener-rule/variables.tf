variable "listener_arn" {
  description = "The ARN of the ALB listener to attach into."
}

variable "priority" {
  description = "The priority of the rule."
}

variable "target_group_arn" {
  description = "The target group to forward"
}

variable "path_pattern" {
  description = "The path pattern of listener rule"
  type        = list(string)
  default     = []
}
