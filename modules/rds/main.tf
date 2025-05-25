# ================================================
# FILE: modules/rds/main.tf
# ================================================
resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "rds-subnet-group"
    Environment = "production"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage      = 20
  max_allocated_storage  = 100
  engine                 = "sqlserver-ex"
  engine_version         = "15.00.4073.23.v1"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  tags = {
    Name        = "main-rds"
    Environment = "production"
  }
}

