terraform {
  required_version = var.versao_terraform

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14.1"
    }
  }
}

provider "aws" {
  region = var.aws_regiao
}
