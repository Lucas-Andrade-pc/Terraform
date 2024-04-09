data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
resource "aws_key_pair" "key" {
  key_name   = "ec2-key-pair"
  public_key = file("./ec2.pub")

}
resource "aws_instance" "instance" {
  lifecycle {
    prevent_destroy = true
    replace_triggered_by = [ aws_s3_bucket.create-bucket ]
  }
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [data.terraform_remote_state.vpc.outputs.id_security]
  subnet_id                   = data.terraform_remote_state.vpc.outputs.id_subnet
  key_name = aws_key_pair.key.key_name
  tags = {
    Name = "Server"
  }
}