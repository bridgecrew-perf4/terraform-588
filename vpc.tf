resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.environment
  }
}

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  tags = {
    "Name" = "main"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}