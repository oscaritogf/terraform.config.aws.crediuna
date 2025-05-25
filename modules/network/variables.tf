# modules/network/variables.tf
variable "vpc_cidr" {
  description = "CIDR block para VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks para subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks para subnets privadas"
  type        = list(string)
}

variable "availability_zones" {
  description = "Zonas de disponibilidad"
  type        = list(string)
}