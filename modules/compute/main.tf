# ================================================
# FILE: modules/compute/main.tf
# ================================================
resource "aws_instance" "frontend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.frontend_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  iam_instance_profile        = var.iam_instance_profile

  tags = {
    Name        = "frontend-server"
    Environment = "production"
    Type        = "frontend"
  }

  user_data = base64encode(templatefile("${path.module}/user_data_frontend.sh", {
    github_token    = var.github_token
    github_org      = var.github_org
    frontend_repo   = var.frontend_repo
    s3_bucket_name  = var.s3_bucket_name
  }))
}

resource "aws_instance" "backend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.backend_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  iam_instance_profile        = var.iam_instance_profile

  tags = {
    Name        = "backend-server"
    Environment = "production"
    Type        = "backend"
  }

  user_data = base64encode(templatefile("${path.module}/user_data_backend.sh", {
    github_token   = var.github_token
    github_org     = var.github_org
    backend_repo   = var.backend_repo
    rds_endpoint   = var.rds_endpoint
    s3_bucket_name = var.s3_bucket_name
  }))
}
