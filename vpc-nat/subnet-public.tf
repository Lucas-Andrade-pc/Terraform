resource "aws_subnet" "subnet-public" {
  count                   = length(var.subnet_public)
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = element(var.subnet_public, count.index)
  availability_zone       = element(var.availability_zone_aws, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}${element(["a", "b", "c"], "${count.index}")}"
  }
}