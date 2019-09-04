module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.15.0"

  cidr = "20.10.0.0/16"

  azs              = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24", "20.10.4.0/24"]
  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24", "20.10.14.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24", "20.10.24.0/24"]

  create_database_subnet_group = false

  enable_classiclink             = false
  enable_classiclink_dns_support = false

  enable_nat_gateway = true
  single_nat_gateway = true
  reuse_nat_ips      = false

  manage_default_network_acl = true

  tags = {
    Environment = "production"
    Name        = "Production"
  }
}
