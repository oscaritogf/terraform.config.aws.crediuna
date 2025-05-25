variable "aws_region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block para VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks para subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks para subnets privadas"  
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Zonas de disponibilidad"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
  description = "AMI ID para instancias EC2"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "frontend_ingress_cidr" {
  description = "CIDR permitido para frontend"
  type        = string
  default     = "0.0.0.0/0"
}

variable "backend_ingress_cidr" {
  description = "CIDR permitido para backend"
  type        = string
  default     = "0.0.0.0/0"
}

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "db_password" {
  description = "Contraseña para RDS"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Usuario para RDS"
  type        = string
  default     = "admin"
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


