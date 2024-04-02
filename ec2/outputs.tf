output "ip-public" {
  value = aws_instance.instance.public_ip
}

output "ip-private" {
  value = aws_instance.instance.private_ip
}