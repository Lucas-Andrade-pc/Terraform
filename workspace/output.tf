output "id_subnet" {
  description = "Id subnet"
  value = {
    for key, value in aws_subnet.subnet-main : key => value.id
  }
}

# output "id_security" {
#   description = "id security"
#   value       = aws_security_group.security-group.id
# }