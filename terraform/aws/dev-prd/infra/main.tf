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
  user_data = var.producao ? filebase64("ansible.sh"): ""
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
  availability_zones = [ "${var.region_aws}a", "${var.region_aws}b" ]
  name = var.asgname
  max_size = var.max
  min_size = var.min
  target_group_arns = var.producao ? [ aws_lb_target_group.target_lb[0].arn ] : []
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_schedule" "ligar" {
  scheduled_action_name = "ligar"
  min_size              = 0
  max_size              =  1
  desired_capacity      = 1
  start_time            = timeadd(timestamp(), "10m")
  recurrence            = "0 10 * * MON-FRI" #7 +3h fuso
  autoscaling_group_name = aws_autoscaling_group.asg-grupo.name
}

resource "aws_autoscaling_schedule" "deligar" {
  scheduled_action_name = "deligar"
  min_size              = 0
  max_size              =  1
  desired_capacity      = 0
  start_time            = timeadd(timestamp(), "11m")
  recurrence            = "0 21 * * MON-FRI" #18 +3h fuso
  autoscaling_group_name = aws_autoscaling_group.asg-grupo.name
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.region_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.region_aws}b"
}

resource "aws_lb" "lb" {
  internal = false
  subnets = [ aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id ]
  count = var.producao ? 1 : 0
}

resource "aws_lb_target_group" "target_lb" {
  name = "targetMac"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.vpc_project.id
  count = var.producao ? 1 : 0
}

resource "aws_lb_listener" "entradalb" {
  load_balancer_arn = aws_lb.lb[0].arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_lb[0].arn
  }
  count = var.producao ? 1 : 0
}

resource "aws_autoscaling_policy" "scaling-prd" {
  name = "terraform-scaling"
  autoscaling_group_name = var.asgname
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAvarageCPUUtilization"
    }
    target_value = 50.0
  }
  count = var.producao ? 1 : 0
}

resource "aws_default_vpc" "vpc_project" {
  
}