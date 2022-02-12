# Now, I am creating Public IP for NAT
# NAT gateway will be placed in the public subnet

resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = "eip"
  }
}

resource "aws_nat_gateway" "public_nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-az-1.id

  tags = {
    Name = "public_nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
