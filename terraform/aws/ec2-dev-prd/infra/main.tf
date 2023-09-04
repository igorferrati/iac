terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.region_aws
}

resource "aws_instance" "app_server" {
  ami           = "ami-002829755fa238bfa" #amazon-ubuntu
  instance_type = var.instance
  key_name = var.key

  tags = {
    Name = "instance-ubuntu"
  }
}

resource "aws_key_pair" "chave-ssh" {
  key_name = var.key
  public_key = file("${var.key}.pub")
  
}

#output ip to setup ansible
output "public_ip" {
  value = aws_instance.app_server.public_ip
}