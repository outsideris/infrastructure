module "teslamate" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "teslamate"

  engine            = "postgres"
  engine_version    = "11.5"
  instance_class    = "db.m5.large"
  allocated_storage = 100
  storage_encrypted = true

  username = "teslamate"

  password = var.teslamate_db_password
  port     = "5432"

  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.side_effect_default_sg]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    Owner       = "outsider"
    Environment = "production"
  }

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # DB subnet group
  subnet_ids = data.terraform_remote_state.vpc.outputs.side_effect_private_subnets

  # DB parameter group
  family = "postgres11"

  # DB option group
  major_engine_version = "11.5"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "teslamate"

  # Database Deletion Protection
  deletion_protection = true
}
