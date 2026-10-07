moved {
  from = aws_vpc.acme_vpc
  to   = module.network.aws_vpc.this
}

moved {
  from = aws_subnet.acme_public_subnet
  to   = module.network.aws_subnet.public
}

moved {
  from = aws_internet_gateway.acme_igw
  to   = module.network.aws_internet_gateway.this
}

moved {
  from = aws_route_table.acme_public_rt
  to   = module.network.aws_route_table.public
}

moved {
  from = aws_route.aws_public_internet_routes
  to   = module.network.aws_route.public_internet
}

moved {
  from = aws_route_table_association.acme_public_subnet_association
  to   = module.network.aws_route_table_association.public_subnet
}

moved {
  from = aws_instance.acme_instance
  to   = module.compute.aws_instance.this
}

moved {
  from = aws_security_group.acme_sg
  to   = module.security_group.aws_security_group.this
}