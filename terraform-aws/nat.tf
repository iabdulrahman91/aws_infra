# Now, I am creating Public IP for NAT
# NAT gateway will be placed in the public subnet

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-az-1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
