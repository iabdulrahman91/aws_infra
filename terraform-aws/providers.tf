# Here I specify any dependency to apply the terraform plan to aws
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-2" # ohio region

  # Configuration options
}
