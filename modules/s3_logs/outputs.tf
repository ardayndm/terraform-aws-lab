output "bucket_name" {
  description = "Name of the ALB access logs bucket"
  value       = aws_s3_bucket.logs.id
}
