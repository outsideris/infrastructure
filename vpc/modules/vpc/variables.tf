variable "name" {
  description = "The name for the VPC"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "public_subnets" {
  description = "CIDR list of public subnets"
  type        = "list"
}

variable "private_subnets" {
  description = "CIDR list of private subnets"
  type        = "list"
}

variable "keypair" {
  description = "The keypair name to use for bastion host"
}
