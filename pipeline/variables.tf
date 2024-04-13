variable "region" {
    type = string
    default = "us-east-1"
}

variable "profile" {
    type = string
    default = "aws-lucas"
}

variable "key_public" {
  description = "Chave publica"
  type = string
}