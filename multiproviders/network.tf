resource "aws_subnet" "subnet-main" {
  vpc_id     = module.vpc.vpc_id_default
  cidr_block = "20.0.1.0/24"

  tags = {
    Name = "subnet-1"
  }
}
resource "aws_subnet" "subnet-ohio" {
  provider   = aws.ohio
  vpc_id     = module.vpc.vpc_id_profile_1
  cidr_block = "20.0.1.0/24"

  tags = {
    Name = "subnet-1"
  }
}
resource "aws_subnet" "subnet-sa" {
  provider   = aws.sa
  vpc_id     = module.vpc.vpc_id_profile_2
  cidr_block = "20.0.1.0/24"

  tags = {
    Name = "subnet-1"
  }
}