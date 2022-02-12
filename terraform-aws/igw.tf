# we need Internet Gateway to have internet access 
# we also need to attach it to the VPC we created

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}
