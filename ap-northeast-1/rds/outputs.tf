output "teslamate_db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.teslamate.this_db_instance_address
}

output "teslamate_db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.teslamate.this_db_instance_arn
}

output "teslamate_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.teslamate.this_db_instance_endpoint
}

output "teslamate_db_instance_id" {
  description = "The RDS instance ID"
  value       = module.teslamate.this_db_instance_id
}

output "teslamate_db_instance_name" {
  description = "The database name"
  value       = module.teslamate.this_db_instance_name
}

output "teslamate_db_instance_username" {
  description = "The master username for the database"
  value       = module.teslamate.this_db_instance_username
}

output "teslamate_db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = module.teslamate.this_db_instance_password
}

output "teslamate_db_instance_port" {
  description = "The database port"
  value       = module.teslamate.this_db_instance_port
}
