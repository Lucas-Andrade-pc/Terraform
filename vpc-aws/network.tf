resource "aws_vpc" "vpc_main" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "vpc-main"
  }
}

resource "aws_subnet" "subnet-main" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "20.0.1.0/24"

  tags = {
    Name = "subnet-01"
  }
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }


  tags = {
    Name = "route-table-gateway"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-main.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "security-group" {
  name        = "AllowSsh"
  description = "AllowSsh"
  vpc_id = aws_vpc.vpc_main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}  