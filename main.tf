provider "aws" {
  region = "eu-north-1"
}

module "network" {
  source      = "./modules/network"
  vpc_cidr    = "10.10.0.0/16"
  subnet_cidr = "10.10.1.0/24"
}

module "compute" {
  source = "./modules/compute"

  ami_id            = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  subnet_id         = module.network.subnet_id
  security_group_id = module.security_group.security_group_id

  tags = merge(local.common_tags, {
    Name = "TerraformCreated"
  })

  volume_size = var.environment == "production" ? 20 : 10
}

module "security_group" {
  source      = "./modules/security_group"
  vpc_id      = module.network.vpc_id
  project     = local.project
  environment = local.environment
  ssh_cidr    = "88.230.174.181/32"
}
