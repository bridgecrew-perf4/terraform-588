data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnet_0" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, 0)


  tags = {
    Name = "PublicSubnet0"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, 1)


  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, 2)


  tags = {
    Name = "PublicSubnet2"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, 3)
  map_public_ip_on_launch = false


  tags = {
    Name = "PublicSubnet2"
  }
}