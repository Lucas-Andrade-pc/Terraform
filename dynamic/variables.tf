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

variable "ports" {
  description = "Portas que serao utilizadas"
  type = map(object({
    description = string
    cidr_block  = list(string)
  }))
  default = {
    22 = {
      description = "porta 22 vpn"
      cidr_block  = ["20.0.0.0/16"]
    }
    80 = {
      description = "porta 80 vpn"
      cidr_block  = ["0.0.0.0/0"]
    }
    443 = {
      description = "porta 443 vpn"
      cidr_block  = ["0.0.0.0/0"]
    }
  }
}