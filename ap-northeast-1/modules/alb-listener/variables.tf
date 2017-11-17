variable "alb_arn" {
  description = "The ARN of the ALB to attach the listener."
}

variable "port" {
  description = "The port number to listen."
}

variable "protocol" {
  description = "The protocol to use."
}

variable "certificate_arn" {
  description = "The certificate ARN to use in the ALB. It's only for https protocol."
  default     = ""
}

variable "target_group_arn" {
  description = "The target group to forward"
}
