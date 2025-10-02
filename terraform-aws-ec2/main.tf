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

  ingress {
    description = "HTTPS"
    from_port   = 6443
    to_port     = 6443
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

# Instância master
resource "aws_instance" "master" {
  ami                         = var.ami_id
  instance_type               = var.tipo_instancia_master
  key_name                    = var.nome_ssh_key
  security_groups             = [aws_security_group.ec2_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "k3s-master"
  }
}

# Instância worker
resource "aws_instance" "worker" {
  ami                         = var.ami_id
  instance_type               = var.tipo_instancia_workers
  count                       = var.num_workers
  key_name                    = var.nome_ssh_key
  security_groups             = [aws_security_group.ec2_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "k3s-worker ${count.index + 1}"
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../ansible/inventory.ini", {
    master_public_ip   = aws_instance.master.public_ip
    master_public_dns  = aws_instance.master.public_dns
    worker1_public_ip  = aws_instance.worker[0].public_ip
    worker1_public_dns = aws_instance.worker[0].public_dns
    worker2_public_ip  = aws_instance.worker[1].public_ip
    worker2_public_dns = aws_instance.worker[1].public_dns
  })
  filename = "${path.module}/../ansible/inventory.ini"
}

