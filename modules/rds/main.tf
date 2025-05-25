// modules/rds/main.tf
resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = "sqlserver-ex"
  engine_version       = "15.00.4073.23.v1"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot  = true
  publicly_accessible  = false

  tags = {
    Name = "main-rds"
  }
}
