# ================================================
# FILE: outputs.tf (ROOT)
# ================================================
output "frontend_public_ip" {
  description = "IP pública del servidor frontend"
  value       = module.compute.frontend_public_ip
}

output "backend_public_ip" {
  description = "IP pública del servidor backend"
  value       = module.compute.backend_public_ip
}

output "rds_endpoint" {
  description = "Endpoint del RDS SQL Server"
  value       = module.rds.rds_endpoint
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = module.s3.bucket_name
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}