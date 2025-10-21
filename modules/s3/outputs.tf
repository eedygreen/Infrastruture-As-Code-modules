
output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.bucket.bucket
}

output "config_filename" {
  description = "The name of the file containing the object contents"
  value       = var.config_filename
}
