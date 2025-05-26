#!/bin/bash
set -e

# Log everything
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting frontend server setup..."

# Update system
yum update -y

# Install required packages
yum install -y docker git aws-cli

# Start and enable Docker
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user

# Install Node.js (for frontend build if needed)
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Create app directory
mkdir -p /opt/frontend
cd /opt/frontend

# Clone frontend repository
git clone https://${github_token}@github.com/${github_org}/${frontend_repo}.git .

# Build and deploy frontend
if [ -f "package.json" ]; then
    npm install
    npm run build
fi

# Start frontend service (adjust based on your frontend type)
if [ -f "Dockerfile" ]; then
    docker build -t frontend .
    docker run -d -p 80:80 --restart=always --name frontend \
        -e S3_BUCKET_NAME=${s3_bucket_name} \
        frontend
else
    # Serve static files with nginx if no Dockerfile
    yum install -y nginx
    cp -r dist/* /usr/share/nginx/html/ 2>/dev/null || cp -r build/* /usr/share/nginx/html/ 2>/dev/null || true
    systemctl start nginx
    systemctl enable nginx
fi

echo "Frontend setup completed!"