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

resource "aws_launch_template" "maquina" {
  image_id           = "ami-002829755fa238bfa" 
  instance_type = var.instance
  key_name = var.key
  tags = {
    Name = "instance-ubuntu"
  }
  security_group_names = [ var.securityGroup ]
}

resource "aws_key_pair" "chave-ssh" {
  key_name = var.key
  public_key = file("${var.key}.pub")
  
}

# #output ip to setup ansible
# output "public_ip" {
#   value = aws_instance.app_server.public_ip
# }

resource "aws_autoscaling_group" "asg-grupo" {
  availability_zones = [ "${var.region_aws}a" ]
  name = var.asgname
  max_size = var.max
  min_size = var.min
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}