module "pinkfong6_db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "pinkfong6"

  engine            = "postgres"
  engine_version    = "9.6.3"
  instance_class    = "db.m4.large"
  allocated_storage = 10
  storage_encrypted = false

  name = "pinkfong6"

  username = "outsider"

  password = ""
  port     = "5432"

  vpc_security_group_ids = ["${data.terraform_remote_state.vpc.side_effect_default_sg}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

  subnet_ids = ["${data.terraform_remote_state.vpc.side_effect_private_subnets}"]

  family = "postgres9.6"
  final_snapshot_identifier = "pinkfong-6-db"
}
