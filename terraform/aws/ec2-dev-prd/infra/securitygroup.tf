resource "aws_security_group" "access_default" {
  name = "access_default"
  description = "sg access dev and prd"
  ingress {}
  egress {}
}