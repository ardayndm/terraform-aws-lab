variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"

  validation {
    condition     = contains(["production", "staging"], var.environment)
    error_message = "Environment must be one of: production, staging."
  }
}
