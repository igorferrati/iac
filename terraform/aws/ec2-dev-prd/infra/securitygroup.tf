resource "aws_security_group" "access_default" {
  name = "access_default"
  description = "sg access dev and prd"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ] #full access
    ipv6_cidr_blocks = [ "::/0" ] #full access ipv6
    from_port = 0                 #full ports
    to_port = 0                   #full ports
    protocol = "-1"               #all protocols
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ] #full access
    ipv6_cidr_blocks = [ "::/0" ] #full access ipv6
    from_port = 0                 #full ports
    to_port = 0                   #full ports
    protocol = "-1"               #all protocols
  }
  tags = {
    Name = "access-default"
  }
}