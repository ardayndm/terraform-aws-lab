variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "tags" {
  description = "Tags applied to the S3 bucket"
  type        = map(string)
  default     = {}
}
