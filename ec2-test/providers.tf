provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "martins-terraform-state-storage"
    key            = "dev/terraform.tfstate" # Path inside the bucket
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
