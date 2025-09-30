resource "aws_security_group" "ec2_sg" {
  name        = "${var.projeto}-sg"
  description = "SG liberando acesso SSH e HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.projeto}-SG"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "k8s_control" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.tipo_instancia_master
  count = 1
  key_name      = var.nome_ssh_key
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = data.aws_subnets.default.ids[0]

  root_block_device {
    volume_size = var.tamanho_volume
    volume_type = "gp3"
  }

  tags = {
    Name = var.projeto
  }
}

resource "aws_instance" "worker" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.tipo_instancia_workers
  count         = 2
  key_name      = var.nome_ssh_key
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = data.aws_subnets.default.ids[0]

  root_block_device {
    volume_size = var.tamanho_volume
    volume_type = "gp3"
  }

  tags = {
    Name = var.projeto
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.ini.j2", {
    public_ip = aws_instance.k8s_control.public_ip
  })
  filename = "${path.module}/../ansible/inventory.ini"
}
