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
  public_key = file("")
}

resource "aws_instance" "vm" {
  count                       = 5
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3a.large"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = "subnet-0ed4bbc046e29491b"
  availability_zone           = "us-east-1c"
  vpc_security_group_ids      = ["sg-0018c35c961d27323"]
  associate_public_ip_address = true

}
resource "aws_ebs_volume" "ebs" {
  count             = 5
  type              = "gp3"
  availability_zone = "us-east-1c"
  size              = 20
}
resource "aws_volume_attachment" "ebs_att" {
  count       = 5
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs[count.index].id
  instance_id = aws_instance.vm[count.index].id
}
