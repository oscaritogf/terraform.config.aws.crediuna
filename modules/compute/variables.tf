
# ================================================
# FILE: modules/compute/variables.tf
# ================================================
variable "ami_id" {
  description = "AMI ID para las instancias EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "public_subnet_id" {
  description = "ID de la subnet pública"
  type        = string
}

variable "frontend_sg_id" {
  description = "ID del security group del frontend"
  type        = string
}

variable "backend_sg_id" {
  description = "ID del security group del backend"
  type        = string
}

variable "key_name" {
  description = "Nombre del key pair para SSH"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "Nombre de la organización GitHub"
  type        = string
}

variable "frontend_repo" {
  description = "Nombre del repositorio frontend"
  type        = string
}

variable "backend_repo" {
  description = "Nombre del repositorio backend"
  type        = string
}

variable "iam_instance_profile" {
  description = "Nombre del IAM instance profile"
  type        = string
}

variable "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "key_name" {
  description = "Nombre de la clave SSH para EC2"
  type        = string
}