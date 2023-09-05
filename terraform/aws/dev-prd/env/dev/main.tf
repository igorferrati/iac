module "aws-dev" {
  source = "../../infra"
  instance = "t2.micro"
  region_aws = "us-west-2"
  key = "iac-dev"
  securityGroup = "sg-dev"
}

#output ip to setup ansible
output "public_ip_dev" {
  value = module.aws-dev.public_ip
}