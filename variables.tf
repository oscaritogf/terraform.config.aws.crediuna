variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "key_pair_name" {
  description = "Nombre del par de llaves SSH para las instancias EC2"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token para clonar repos privados"
  type        = string
  sensitive   = true
}

variable "github_org" {
  description = "Nombre de la organización en GitHub"
  type        = string
}

variable "frontend_repo" {
  description = "Nombre del repositorio del frontend"
  type        = string
}

variable "backend_repo" {
  description = "Nombre del repositorio del backend"
  type        = string
}

variable "rds_username" {
  description = "Usuario para la base de datos RDS"
  type        = string
}

variable "rds_password" {
  description = "Contraseña para la base de datos RDS"
  type        = string
  sensitive   = true
}
