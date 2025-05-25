# ================================================
# FILE: modules/security/outputs.tf
# ================================================
output "frontend_sg_id" {
  description = "ID del security group del frontend"
  value       = aws_security_group.frontend_sg.id
}

output "backend_sg_id" {
  description = "ID del security group del backend"
  value       = aws_security_group.backend_sg.id
}

output "rds_sg_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds_sg.id
}