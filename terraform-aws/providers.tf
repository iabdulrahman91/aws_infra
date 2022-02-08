# Here I specify any dependency to apply the terraform plan to aws

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.1"
    }
  }
}

provider "aws" {
    region = "us-east-2"

  # Configuration options
}
