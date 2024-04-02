output "id_subnet" {
  description = "Id subnet"
  value       = aws_subnet.subnet-main.id
}

output "id_security" {
  description = "id security"
  value       = aws_security_group.security-group.id
}