data "aws_availability_zones" "available" {}
resource "aws_vpc" "vpc_main" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "vpc-main"
  }
}

resource "aws_subnet" "subnet-main" {
  count      = 6
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "20.0.${count.index}.0/24"
  availability_zone  = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-${count.index}"
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
  count          = 6
  subnet_id      = aws_subnet.subnet-main[count.index].id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "security-group" {
  name        = "AllowSsh"
  description = "AllowSsh"
  vpc_id      = aws_vpc.vpc_main.id
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
resource "aws_security_group" "ecs-security-group" {
  name        = "ecs-security-group"
  description = "ecs-security-group"
  vpc_id      = aws_vpc.vpc_main.id
  ingress {
   from_port   = 0
   to_port     = 0
   protocol    = -1
   self        = "false"
   cidr_blocks = ["0.0.0.0/0"]
   description = "any"
 }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "application_security_group" {
  name   = "application-security-group"
  vpc_id = aws_vpc.vpc_main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
    description = "any"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}