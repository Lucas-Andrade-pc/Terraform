output "vpc_id_default" {
  value = aws_vpc.vpc_main.id
}
output "vpc_id_profile_1" {
  value = aws_vpc.profile_1.id
}
output "vpc_id_profile_2" {
  value = aws_vpc.profile_2.id
}