variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
variable "subnet_id_a" {
  description = "ID of the first public subnet"
  type        = string
}
variable "subnet_id_b" {
  description = "ID of the second public subnet"
  type        = string
}

variable "target_instance_id" {
  description = "ID of the target instance"
  type        = string
}

variable "target_security_group_id" {
  description = "Security group attached to the backend EC2 instance"
  type        = string
}

variable "health_check_path" {
  description = "HTTP path used by the target group health check"
  type = string
  default = "/"
}

variable "access_logs_bucket_name" {
  description = "S3 bucket name used to store ALB access logs"
  type = string
}