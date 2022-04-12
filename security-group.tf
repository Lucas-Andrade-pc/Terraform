resource "aws_security_group" "acesso-ssh" { 
    name =  "acesso-ssh"
    description = "acesso-ssh"

    ingress {
        description = "ssh"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "${var.cidr_acesso}"
    }

    tags = {
        Name = "ssh"
    }
}

# Novo security-group para a nova regiao poder acessar com o ssh
# Precisamos tambem importar a nossa chave que geramos localmente para a nova regiao
# Assim conseguimos acessar as nossas novas instancias com o ssh

resource "aws_security_group" "acesso-ssh-us-east-2" { 
    provider = "aws.us-east-2"
    name =  "acesso-ssh-us-east-2"
    description = "acesso-ssh-us-east-2"

    ingress {
        description = "ssh"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = "${var.cidr_acesso}"
    }

    tags = {
        Name = "ssh"
    }
}