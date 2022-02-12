# Creating routing tables (Private and Public) and associating subnets with them
# nat_gatway for private table
# internet_gateway for public table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat.id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public"
  }
}

# Private Routing Table <----> Private subnet AZ1
resource "aws_route_table_association" "private-az-1" {
  subnet_id      = aws_subnet.private-az-1.id
  route_table_id = aws_route_table.private.id
}

# Private Routing Table <----> Private subnet AZ2
resource "aws_route_table_association" "private-az-2" {
  subnet_id      = aws_subnet.private-az-2.id
  route_table_id = aws_route_table.private.id
}

# Public Routing Table <----> Public subnet AZ1
resource "aws_route_table_association" "public-az-1" {
  subnet_id      = aws_subnet.public-az-1.id
  route_table_id = aws_route_table.public.id
}

# Public Routing Table <----> Public subnet AZ2
resource "aws_route_table_association" "public-az-2" {
  subnet_id      = aws_subnet.public-az-2.id
  route_table_id = aws_route_table.public.id
}
