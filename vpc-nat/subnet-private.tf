resource "aws_subnet" "subnet-private" {
  count             = length(var.subnet_private)
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = element(var.subnet_private, count.index)
  availability_zone = element(var.availability_zone_aws, count.index + 3)
  tags = {
    Name = "private-subnet-${count.index + 1}${element(["a", "b", "c"], "${count.index}")}"
  }
}