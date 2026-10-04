output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.acme_instance.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.acme_instance.private_ip
}

output "module_security_group_id" {
  description = "Security group ID from the security group module"
  value       = module.security_group.security_group_id
}