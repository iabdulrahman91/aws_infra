# Create IAM Role for proper policy to manage EKS
resource "aws_iam_role" "eks-role" {

  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-role-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-role.name
}


# Creating EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "main-cluster"
  role_arn = aws_iam_role.eks-role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-az-1.id,
      aws_subnet.private-az-2.id,
      aws_subnet.public-az-1.id,
      aws_subnet.public-az-2.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks-role-AmazonEKSClusterPolicy]
}
