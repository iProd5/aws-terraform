# provider "aws" {
#   profile = "default"
#   region  = "us-east-1"
# }

# resource "aws_instance" "example" {
#   ami           = "ami-2757f631"
#   instance_type = "t2.micro"
# }
provider "aws" {
  region = "us-west-2"
}

locals {
  security_group_rules = csvdecode(file("${path.module}/security-group-rules.csv"))
}

resource "aws_security_group_rule" "windows_server_rules" {
  count = length(local.security_group_rules)

  security_group_id = "sg-1234"
  type              = local.security_group_rules[count.index].type
  protocol          = local.security_group_rules[count.index].protocol
  from_port         = local.security_group_rules[count.index].from
  to_port           = local.security_group_rules[count.index].to
  cidr_blocks       = [local.security_group_rules[count.index].cidr_blocks]
  description       = local.security_group_rules[count.index].comment
}