variable "region_eua" {
  description = "Reion onde sera criado o recurso"
  type        = string
  default     = "us-east-1"
}
variable "region_ohio" {
  description = "Reion onde sera criado o recurso"
  type        = string
  default     = "us-east-2"
}
variable "region_sa" {
  description = "Reion onde sera criado o recurso"
  type        = string
  default     = "sa-east-1"
}

variable "profile" {
  description = "Conta da aws a ser utilizada"
  type        = string
  default     = "aws-lucas"
}