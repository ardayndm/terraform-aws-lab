resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true

  tags = var.tags

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
  }
}
