#!/bin/bash
set -e

# Log everything
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting backend server setup..."

# Update system
yum update -y

# Install required packages
yum install -y docker git aws-cli

# Start and enable Docker
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user

# Install Node.js
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Create app directory
mkdir -p /opt/backend
cd /opt/backend

# Clone backend repository
git clone https://${github_token}@github.com/${github_org}/${backend_repo}.git .

# Set environment variables
cat >> /etc/environment << EOF
RDS_ENDPOINT=${rds_endpoint}
S3_BUCKET_NAME=${s3_bucket_name}
NODE_ENV=production
EOF

# Build and run backend
if [ -f "Dockerfile" ]; then
    docker build -t backend .
    docker run -d -p 3000:3000 --restart=always --name backend \
        -e RDS_ENDPOINT=${rds_endpoint} \
        -e S3_BUCKET_NAME=${s3_bucket_name} \
        -e NODE_ENV=production \
        backend
elif [ -f "package.json" ]; then
    # Direct Node.js deployment
    npm install
    
    # Install PM2 for process management
    npm install -g pm2
    
    # Create PM2 ecosystem file
    cat > ecosystem.config.js << EOF
module.exports = {
  apps: [{
    name: 'backend',
    script: 'app.js', // or your main file
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'production',
      RDS_ENDPOINT: '${rds_endpoint}',
      S3_BUCKET_NAME: '${s3_bucket_name}'
    }
  }]
}
EOF
    
    # Start with PM2
    pm2 start ecosystem.config.js
    pm2 startup
    pm2 save
fi

echo "Backend setup completed!"