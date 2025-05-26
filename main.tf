
# ================================================
# FILE: /main.tf
# ================================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
  frontend_ingress_cidr = var.frontend_ingress_cidr
  backend_ingress_cidr = var.backend_ingress_cidr
}

module "compute" {
  source = "./modules/compute"

  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair_name
  github_token = var.github_token
  github_org = var.github_org
  backend_repo = var.backend_repo
  frontend_repo = var.frontend_repo

  public_subnet_id = module.network.public_subnet_ids[0]
  backend_sg_id = module.security.backend_sg_id
  frontend_sg_id = module.security.frontend_sg_id
  iam_instance_profile = module.s3.iam_instance_profile_name

   rds_endpoint        = module.rds.rds_endpoint    
  s3_bucket_name      = module.s3.bucket_name
}

module "rds" {
  source = "./modules/rds"

  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
  private_subnet_ids = module.network.private_subnet_ids
  rds_sg_id = module.security.rds_sg_id
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}



