module "aws-prd" {
  source = "../../infra"
  instance = "t2.micro"
  region_aws = "us-west-2"
  key = "iac-prd"
  securityGroup = "sgprd"
  min = 1
  max = 5
  asgname = "asg-prod"
}

# #output ip to setup ansible
# output "public_ip_dev" {
#   value = module.aws-prd.public_ip
# }