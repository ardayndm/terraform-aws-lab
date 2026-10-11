resource "aws_security_group" "alb" {
  name   = "acme-alb-sg"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_lb" "this" {
  name               = "acme-alb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    var.subnet_id_a,
    var.subnet_id_b
  ]

  security_groups = [
    aws_security_group.alb.id
  ]

  access_logs {
    bucket  = var.access_logs_bucket_name
    enabled = true
  }
}

resource "aws_lb_target_group" "app" {
  name        = "acme-app-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = var.health_check_path
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = var.target_instance_id
  port             = 8080
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_vpc_security_group_egress_rule" "to_app" {
  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = var.target_security_group_id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}
