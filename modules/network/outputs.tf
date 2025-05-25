# modules/network/outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {  # Plural y array
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {  # Agregar este output
  value = aws_subnet.private[*].id
}