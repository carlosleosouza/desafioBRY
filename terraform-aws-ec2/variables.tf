variable "aws_regiao" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "tipo_instancia_master" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "tipo_instancia_workers" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
  description = "Versão da AMI - Ubuntu 24.04"
  type        = string
  default     = "ami-0e8459476fed2e23b"
}

variable "num_workers" {
  default = 2
}
variable "nome_ssh_key" {
  description = "Nome da chave SSH já criada na AWS"
  type        = string
  default = "minha-chave-k3s"
}

variable "tamanho_volume" {
  description = "Tamanho do disco EBS em GB"
  type        = number
  default     = 8
}

variable "projeto" {
  description = "Projeto BRY"
  type        = string
  default     = "k8s-BRY"
}

variable "versao_terraform" {
  description = "Versão do Terraform"
  type = string
  default = "1.5.0"
}