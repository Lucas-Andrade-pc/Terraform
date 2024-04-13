resource "aws_vpc" "vpc_main" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "vpc-${terraform.workspace}"
  }
}

resource "aws_subnet" "subnet-main" {
  count      = terraform.workspace == "prod" ? 3 : 1
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "20.0.${count.index}.0/24"

  tags = {
    Name = "subnet-${terraform.workspace}-${count.index}"
  }
}
  