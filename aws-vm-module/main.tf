terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.43.0"
    }
  }
  backend "s3" {
    bucket  = "descomplicando-terraform-remote-state"
    key     = "ec2-modules/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # profile = "aws-lucas"
  }
}

provider "aws" {
  # access_key = ""
  # secret_key = ""
  region  = var.region
  profile = var.profile
  default_tags {
    tags = local.common_tags
  }
}

module "network" {
  source = "./network"

  cidr-vpc = "20.0.0.0/16"
  subnet-cidr = "20.0.1.0/24"
  environment = "dev"
}