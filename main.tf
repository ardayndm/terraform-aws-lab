provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "acme_vpc" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "acme_public_subnet" {
  vpc_id     = aws_vpc.acme_vpc.id
  cidr_block = "10.10.1.0/24"
}

resource "aws_internet_gateway" "acme_igw" {
  vpc_id = aws_vpc.acme_vpc.id
}

resource "aws_route_table" "acme_public_rt" {
  vpc_id = aws_vpc.acme_vpc.id
}

resource "aws_route" "aws_public_internet_routes" {
  route_table_id         = aws_route_table.acme_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.acme_igw.id
}

resource "aws_route_table_association" "acme_public_subnet_association" {
  subnet_id      = aws_subnet.acme_public_subnet.id
  route_table_id = aws_route_table.acme_public_rt.id
}

resource "aws_security_group" "acme_sg" {
  name        = "${local.project}_sg"
  description = "Security group for acme"
  vpc_id      = aws_vpc.acme_vpc.id

  ingress {
    # SSH
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["88.230.174.181/32"]
  }

  ingress {
    ## HTTP
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "acme_instance" {
  # ami                         = "ami-0769f265f707fecc8"
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.acme_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.acme_sg.id]
  associate_public_ip_address = true
  tags = merge(local.common_tags, {
    Name = "TerraformCreated"
  })

  # Root volume configuration
  root_block_device {
    volume_type = "gp3"
    volume_size = var.environment == "production" ? 20 : 10
  }
}

module "security_group" {
  source      = "./modules/security_group"
  vpc_id      = aws_vpc.acme_vpc.id
  project     = local.project
  environment = local.environment
}

resource "aws_security_group" "legacy_sg" {
  name        = "acme-import-test"
  description = "Terraform import test"
  vpc_id      = aws_vpc.acme_vpc.id
}
