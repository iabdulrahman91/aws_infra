# We need to have two Availablity zones
# Each AZ will have two subnets (private and public) to meet EKS requirments

locals {
  az_1 = "us-east-2a"
  az_2 = "us-east-2b"
}

resource "aws_subnet" "private-az-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = local.az_1

  tags = {
    "Name"                            = "private-${local.az_1}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/main-cluster"      = "owned"
  }
}

resource "aws_subnet" "private-az-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = local.az_2

  tags = {
    "Name"                            = "private-${local.az_2}"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/main-cluster"      = "owned"
  }
}

resource "aws_subnet" "public-az-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = local.az_1
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-${local.az_1}"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/main-cluster" = "owned"
  }
}

resource "aws_subnet" "public-az-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = local.az_2
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-${local.az_2}"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/main-cluster" = "owned"
  }
}
