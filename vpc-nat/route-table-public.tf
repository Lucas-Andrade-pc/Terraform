resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }
  tags = {
    Name = "${var.aws_route_table_public}"
  }
}

resource "aws_route_table_association" "association-public-subnet" {
  count          = length(var.subnet_public)
  subnet_id      = aws_subnet.subnet-public[count.index].id
  route_table_id = aws_route_table.route-table-public.id
}