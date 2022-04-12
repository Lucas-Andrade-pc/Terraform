provider "aws" { # qual provedor eu quero configurar
  version = "~> 2.0" # minha versão
  region = "us-east-1" # qual a minha região
}


provider "aws" { # qual provedor eu quero configurar
  alias = "us-east-2"
  version = "~> 2.0" # minha versão
  region = "us-east-2" # qual a minha região
}
# cenario: eu queria preparar um ambiente para o time dev

resource "aws_instance" "dev" { # dizemos o tipo da instancia e o nome qualquer para essa instancia
  count = 3 # quantidade de maquinas
  #parametros 
  ami = "${var.amis["us-east-1"]}" # imagem da minha maquina por exemplo ami-04505e74c0741db8d
  instance_type = "t2.micro" # tipo da instancia

  # gerar chave local para ter acesso em diferentes plataformas - ssh-keygen -f terraform-aws -t rsa
  # e importamos a chave na aws
  key_name = "${var.key_name}"
  tags = { #nome as recursos
    Name = "dev${count.index}" # dev0; dev1; dev2 
  }
  # precisamos vincular nosso security grupo a nossas instancias
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] # id do security grupo

  # fazer o deply, no terminal "terraform init". Depois "terraform plan"
  # depois aplicamos nosso planejamento "terraform apply"
  # terraform show - mostar como ta o ambiente
  # aws ec2 describe-security-groups
}
resource "aws_instance" "dev4" { 
  ami = "${var.amis["us-east-1"]}" 
  instance_type = "t2.micro" 
  key_name = "${var.key_name}"
  tags = { 
    Name = "dev4" 
  }
 
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] 
  depends_on = [
    aws_s3_bucket.bucket-dev4
  ]

}
resource "aws_instance" "dev5" { 
  ami =  "${var.amis["us-east-1"]}"
  instance_type = "t2.micro" 
  key_name = "${var.key_name}"
  tags = { 
    Name = "dev5" 
  }
 
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] 

}

#criamos uma nova maquina na nova regiao aws.us-east-2 e vinculamos com o nosso database com o depend

resource "aws_instance" "dev6" { 
  provider = "aws.us-east-2"
  ami =  "${var.amis["us-east-2"]}"
  instance_type = "t2.micro" 
  key_name = "${var.key_name}"
  tags = { 
    Name = "dev6" 
  }
 
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"] 
  depends_on = [
    aws_dynamodb_table.dynamodb-homologacao
  ]

}

resource "aws_instance" "dev7" { 
  provider = "aws.us-east-2"
  ami =  "${var.amis["us-east-2"]}"
  instance_type = "t2.micro" 
  key_name = "${var.key_name}"
  tags = { 
    Name = "dev7" 
  }
 
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"] 

}


resource "aws_s3_bucket" "bucket-dev4" {
  bucket  = "dev-rmerceslabs-dev4"
  acl     = "private"

  tags = {
    Name  = "rmerceslabs-dev4"
  }
  
}

# Criamos um database na nova regiao aws.us-east-2 

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = "aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}