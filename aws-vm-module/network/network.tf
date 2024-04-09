resource "aws_vpc" "vpc_main" {
  cidr_block = var.cidr-vpc

  tags = {
    Name = "vpc-main-${var.environment}"
  }
}

resource "aws_subnet" "subnet-main" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = var.subnet-cidr

  tags = {
    Name = "subnet-01-${var.environment}"
  }
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "internet-gateway-${var.environment}"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }


  tags = {
    Name = "route-table-gateway-${var.environment}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-main.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "security-group" {
  name        = "AllowSsh-${var.environment}"
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