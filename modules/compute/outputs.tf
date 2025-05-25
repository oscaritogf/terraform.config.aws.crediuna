# ================================================
# FILE: modules/compute/outputs.tf
# ================================================
output "frontend_public_ip" {
  description = "IP pública del servidor frontend"
  value       = aws_instance.frontend.public_ip
}

output "frontend_private_ip" {
  description = "IP privada del servidor frontend"
  value       = aws_instance.frontend.private_ip
}

output "backend_public_ip" {
  description = "IP pública del servidor backend"
  value       = aws_instance.backend.public_ip
}

output "backend_private_ip" {
  description = "IP privada del servidor backend"
  value       = aws_instance.backend.private_ip
}

output "frontend_instance_id" {
  description = "ID de la instancia frontend"
  value       = aws_instance.frontend.id
}

output "backend_instance_id" {
  description = "ID de la instancia backend"
  value       = aws_instance.backend.id
}
