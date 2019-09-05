variable "name" {
  description = "The name to use for the ALB and all other resources in this module."
}

variable "subnet_ids" {
  description = "The subnet IDs into which the ALB should be deployed."
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "The security groups into which the ALB should be applied."
  type        = list(string)
  default     = []
}

variable "log_bucket" {
  description = "S3 bucket name to write ALB logs into"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

