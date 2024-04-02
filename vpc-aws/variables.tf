variable "region" {
  description = "Reion onde sera criado o recurso"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "Conta da aws a ser utilizada"
  type        = string
  default     = "aws-lucas"
}