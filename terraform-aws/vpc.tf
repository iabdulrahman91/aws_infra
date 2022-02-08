# Definetly I need Virtual Private Cloud (VPC) to build EKS
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}