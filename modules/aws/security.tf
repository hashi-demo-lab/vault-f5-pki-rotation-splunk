module "sg-ssh" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name   = "${var.deployment_id}-ssh"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    }
  ]
}