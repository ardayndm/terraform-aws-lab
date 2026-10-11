variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "subnet2_cidr" {
  description = "CIRD block for the second public subnet"
  type        = string
}

variable "availability_zone_a" {
  description = "Availability Zone for the first public subnet"
  type        = string
}

variable "availability_zone_b" {
  description = "Availability Zone for the second public subnet"
  type        = string
}