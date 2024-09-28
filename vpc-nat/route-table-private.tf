resource "aws_eip" "eip_nat" {
  domain = "vpc"
}
resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = element(aws_subnet.subnet-public[*].id, 2)
}
resource "aws_route_table" "route-table-private" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng.id
  }
  tags = {
    Name = "${var.aws_route_table_private}"
  }
}

resource "aws_route_table_association" "association-private-subnet" {
  count          = length(var.subnet_private)
  subnet_id      = aws_subnet.subnet-private[count.index].id
  route_table_id = aws_route_table.route-table-private.id
}