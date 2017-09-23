variable "listener_arn" {
  description = "The ARN of the ALB listener to attach into."
}

variable "priority" {
  description = "The priority of the rule."
}

variable "target_group_arn" {
  description = "The target group to forward"
}

variable "condition_field" {
  description = "The condition name of listener rule, must be one of path-pattern or host-header"
}

variable "condition_values" {
  description = "The patterns to match."
  type        = "list"
  default     = []
}
