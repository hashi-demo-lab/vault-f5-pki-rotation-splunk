module "sg-ssh" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name   = "${var.deployment_id}-all"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = [
                    "http-80-tcp",
                    "https-443-tcp",
                    "ssh-tcp"
                    
  ]
  
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["ssh-tcp", "https-443-tcp"]
}