# ================================================
# FILE: modules/security/variables.tf
# ================================================
variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "frontend_ingress_cidr" {
  description = "CIDR permitido para acceso al frontend"
  type        = string
}

variable "backend_ingress_cidr" {
  description = "CIDR permitido para acceso al backend"
  type        = string
}