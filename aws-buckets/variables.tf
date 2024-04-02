variable "location" {
  description = "Region AWS"
  type        = string
  default     = "us-east-1"
}

variable "profile_aws" {
  description = "Profile aws"
  type        = string
  default     = "aws-lucas"
}

variable "name_bucket" {
  description = "Name bucket"
  type        = string
  default     = "descomplicando-terraform-state"
}