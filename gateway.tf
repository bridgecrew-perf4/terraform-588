resource "aws_internet_gateway" "nbrown" {
  vpc_id = aws_vpc.nbrown.id

  tags = {
    Name = "nbrown"
  }
}