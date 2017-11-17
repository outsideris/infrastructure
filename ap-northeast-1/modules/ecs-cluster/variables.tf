variable "name" {
  description = "The name for the VPC"
}

variable "keypair" {
  description = "The keypair name to use for instances of the ECS cluster"
}

variable "security_groups" {
  description = "The security groups into which the instances should be applied."
  type        = "list"
  default     = []
}

variable "availability_zones" {
  description = "The availability zones of the VPC which the cluster in"
  type        = "list"
}

variable "subnets" {
  description = "The subnets which the cluster in."
  default     = []
}

variable "cluster_min_size" {
  description = "The minimum size for instance of the cluster."
}

variable "cluster_max_size" {
  description = "The maximum size for instance of the cluster."
}

variable "cluster_desired_capacity" {
  description = "The desired capacity for instance of the cluster."
}

variable "instance_type" {
  description = "The instance type of the cluster."
}

variable "environment" {
  description = "Environment tag, e.g prod"
}
