module "sg-mgmt" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name   = "${var.deployment_id}-all"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["202.137.173.136/32"]
  ingress_rules = var.mgmt_ingress_rules
  
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = var.mgmt_egress_rules
}