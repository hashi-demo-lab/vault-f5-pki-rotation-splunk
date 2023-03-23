# creating a dynamic public/private key for use by Terraform provisioner
# Used in main.tf to configure the AWS instance with a provisioner
module "key_pair" {
  source             = "terraform-aws-modules/key-pair/aws"
  version            = "2.0.0"

  key_name           = "deployer-one"
  create_private_key = true
}

