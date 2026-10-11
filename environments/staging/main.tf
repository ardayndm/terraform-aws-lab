module "network" {
  source = "../../modules/network"

  vpc_cidr            = "10.20.0.0/16"
  subnet_cidr         = "10.20.1.0/24"
  subnet2_cidr        = "10.20.2.0/24"
  availability_zone_a = "eu-north-1a"
  availability_zone_b = "eu-north-1b"
}

module "security_group" {
  source      = "../../modules/security_group"
  vpc_id      = module.network.vpc_id
  project     = local.project
  environment = local.environment
  ssh_cidr    = "88.230.181.90/32"
}

module "compute" {
  source            = "../../modules/compute"
  ami_id            = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  subnet_id         = module.network.subnet_id
  security_group_id = module.security_group.security_group_id

  tags = merge(local.common_tags, {
    Name = "TerraformCreated"
  })

  volume_size = 10
}

module "s3_logs" {
  source      = "../../modules/s3_logs"
  bucket_name = "acme-alb-access-logs-870318142654"
  tags        = local.common_tags
}

module "load_balancer" {
  source     = "../../modules/load_balancer"
  depends_on = [module.s3_logs]

  vpc_id                   = module.network.vpc_id
  subnet_id_a              = module.network.subnet_id
  subnet_id_b              = module.network.subnet2_id
  target_instance_id       = module.compute.instance_id
  target_security_group_id = module.security_group.security_group_id
  health_check_path        = "/"
  access_logs_bucket_name  = module.s3_logs.bucket_name
}
