// modules/compute/main.tf
resource "aws_instance" "frontend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.frontend_sg_id]
  key_name                    = var.key_pair
  associate_public_ip_address = true

  tags = {
    Name = "frontend"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo docker run -d -p 80:80 ${var.frontend_image}
              EOF
}

resource "aws_instance" "backend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.backend_sg_id]
  key_name                    = var.key_pair
  associate_public_ip_address = true

  tags = {
    Name = "backend"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker git
              cd /home/ec2-user
              git clone https://github.com/${var.github_org}/${var.backend_repo}.git
              cd ${var.backend_repo}
              sudo service docker start
              sudo docker build -t backend .
              sudo docker run -d -p 3000:3000 backend
              EOF
}
