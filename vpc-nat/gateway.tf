resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "awsnat-gateway"
  }
}