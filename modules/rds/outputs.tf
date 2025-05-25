# ================================================
# FILE: modules/rds/outputs.tf
# ================================================
output "rds_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = aws_db_instance.main.endpoint
}

output "rds_port" {
  description = "Puerto de la instancia RDS"
  value       = aws_db_instance.main.port
}

output "rds_instance_id" {
  description = "ID de la instancia RDS"
  value       = aws_db_instance.main.id
}