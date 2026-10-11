output "instance_id" {
  value = module.compute.instance_id
}

output "instance_public_ip" {
  value = module.compute.public_ip
}

output "instance_private_ip" {
  value = module.compute.private_ip
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.load_balancer.alb_dns_name
}

output "app_url" {
  description = "HTTP URL of the application"
  value       = "http://${module.load_balancer.alb_dns_name}"
}