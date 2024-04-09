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
    key     = "providers/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # profile = "aws-lucas"
  }
}

provider "aws" {
  alias  = "eua"
  region = var.region_eua
  # profile = var.profile
  default_tags {
    tags = local.common_tags
  }
}
provider "aws" {
  alias  = "ohio"
  region = var.region_ohio
  # profile = var.profile
  default_tags {
    tags = local.common_tags
  }
}
provider "aws" {
  alias  = "sa"
  region = var.region_sa
  # profile = var.profile
  default_tags {
    tags = local.common_tags
  }
}

module "vpc" {
  providers = {
    aws.profile_1 = aws.ohio
    aws.profile_2 = aws.sa
  }
  source = "./vpc"
}