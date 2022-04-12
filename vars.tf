variable "amis" { # Nome da variavel
    type = map  # tipo da variavel que vai ser key = value
    default = { # definimos nossas key = value
        us-east-1 = "ami-04505e74c0741db8d"
        us-east-2 = "ami-064ff912f78e3e561"
    }
}

variable "cidr_acesso" {
  type = list
  default = ["IP"]
}

variable "key_name" {
    default = "terraform-aws"
}