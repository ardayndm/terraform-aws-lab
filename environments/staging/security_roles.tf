resource "aws_vpc_security_group_ingress_rule" "ssh_from_my_ip" {
  security_group_id = module.security_group.security_group_id

  cidr_ipv4   = var.ssh_cidr
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  description = "SSH from admin IP"
  depends_on  = [module.security_group]
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id = module.security_group.security_group_id

  referenced_security_group_id = module.load_balancer.alb_security_group_id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
  description                  = "Application traffic from ALB only"
  depends_on                   = [module.security_group]
}

