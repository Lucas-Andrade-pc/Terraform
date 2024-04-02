terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

provider "aws" {
  region  = var.location
  profile = var.profile_aws
  default_tags {
    tags = local.common_tags
  }
}