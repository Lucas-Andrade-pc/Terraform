variable "vpc_name" {
  type    = string
  default = "awsnat"
}
variable "aws_route_table_public" {
  type    = string
  default = "route-table-awsnat-public"
}
variable "aws_route_table_private" {
  type    = string
  default = "route-table-awsnet-private"
}
variable "region" {
  type    = string
  default = "us-east-1"
}
variable "subnet_public" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "subnet_private" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability_zone_aws" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}