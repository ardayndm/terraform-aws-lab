output "instance_public_ip" {
  value = module.compute.public_ip
}

output "instance_private_ip" {
  value = module.compute.private_ip
}

output "module_security_group_id" {
  description = "Security group ID from the security group module"
  value       = module.security_group.security_group_id
}
