resource "aws_subnet" "eu-west-2a" {
  availability_zone = "eu-west-2a"
  vpc_id     = aws_vpc.nbrown.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "eu-west-2a"
  }
}

resource "aws_subnet" "eu-west-2b" {
  availability_zone = "eu-west-2b"
  vpc_id     = aws_vpc.nbrown.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "eu-west-2b"
  }
}

resource "aws_subnet" "eu-west-2c" {
  availability_zone = "eu-west-2c"
  vpc_id     = aws_vpc.nbrown.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "eu-west-2c"
  }
}