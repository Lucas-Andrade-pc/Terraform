terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "aws-lucas"
  default_tags {
    tags = local.common_tags
  }
}