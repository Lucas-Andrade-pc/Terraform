output "id_vpc" {
  description = "id cpv"
  value       = aws_vpc.vpc_main.id
}
output "id_subnet" {
  description = "Id subnet"
  value = {
    for key, value in aws_subnet.subnet-main : key => value.id
  }
}

output "id_security" {
  description = "id security"
  value       = aws_security_group.security-group.id
}

output "id_security_application" {
  description = "id application"
  value       = aws_security_group.application_security_group.id
}
output "id_security_ecs" {
  description = "id security ecs"
  value       = aws_security_group.ecs-security-group.id
}