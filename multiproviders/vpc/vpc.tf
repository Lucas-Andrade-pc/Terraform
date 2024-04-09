resource "aws_vpc" "vpc_main" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "vpc-main-eua"
  }
}
resource "aws_vpc" "profile_1" {
  provider   = aws.profile_1
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "vpc-main-ohio"
  }
}
resource "aws_vpc" "profile_2" {
  provider   = aws.profile_2
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "vpc-main-sa"
  }
}