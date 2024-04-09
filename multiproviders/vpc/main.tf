terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "5.43.0"
      configuration_aliases = [aws.profile_1, aws.profile_2]
    }
  }
}