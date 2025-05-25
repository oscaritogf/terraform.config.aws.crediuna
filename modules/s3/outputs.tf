
# ================================================
# FILE: modules/s3/outputs.tf
# ================================================
output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.app_bucket.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.app_bucket.arn
}

output "bucket_domain_name" {
  description = "Domain name del bucket S3"
  value       = aws_s3_bucket.app_bucket.bucket_domain_name
}

output "iam_instance_profile_name" {
  description = "Nombre del instance profile para EC2"
  value       = aws_iam_instance_profile.ec2_s3_profile.name
}

output "iam_role_arn" {
  description = "ARN del IAM role"
  value       = aws_iam_role.ec2_s3_role.arn
}