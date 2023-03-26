locals {

}

resource "random_string" "suffix" {
  length  = 8
  special = false
}


// hashicorp cloud platform (hcp) infrastructure
module "hcp-hvn" {
  source = "./modules/hcp"

  region                     = var.aws_region
  deployment_id              = local.deployment_id
  cidr                       = var.hcp_hvn_cidr
  aws_vpc_cidr               = var.aws_vpc_cidr
  aws_tgw_id                 = module.infra-aws.tgw_id
  aws_ram_resource_share_arn = module.infra-aws.ram_resource_share_arn
}

// amazon web services (aws) infrastructure
module "infra-aws" {
  source = "./modules/aws"

  region                      = var.aws_region
  owner                       = var.owner
  ttl                         = var.ttl
  deployment_id               = local.deployment_id
  vpc_cidr                    = var.aws_vpc_cidr
  public_subnets              = var.aws_public_subnets
  private_subnets             = var.aws_private_subnets
  eks_cluster_version         = var.aws_eks_cluster_version
  eks_cluster_service_cidr    = var.aws_eks_cluster_service_cidr
  eks_worker_instance_type    = var.aws_eks_worker_instance_type
  eks_worker_desired_capacity = var.aws_eks_worker_desired_capacity
  hcp_hvn_provider_account_id = module.hcp-hvn.provider_account_id
  hcp_hvn_cidr                = var.hcp_hvn_cidr
  ssh_pubkey                  = var.ssh_pubkey
  aws_key_pair_key_name       = var.aws_key_pair_key_name
  ingress_cidr_blocks         = var.ingress_cidr_blocks
}

//SSM Doc for Vault agent pre-reqs
locals {
  ssm_document_content = file("${path.module}/files/vault_agent.yaml")
}

resource "aws_ssm_document" "run_script_document" {
  name            = "vault_script_document"
  document_type   = "Command"
  document_format = "YAML"
  content         = local.ssm_document_content
}

resource "aws_ssm_association" "example" {
  name = aws_ssm_document.run_script_document.name

  targets {
    key    = "InstanceIds"
    values = [module.infra-aws.bastion_ec2_instance_id]
  }
}


// hcp vault
module "hcp-vault" {
  source = "./modules/vault/"

  deployment_name = var.deployment_name
  hvn_id          = module.hcp-hvn.id
  tier            = var.hcp_vault_tier
}


# F5VE using AWS Marketplace - min size and speed for lowest cost
module "bigip" {
  depends_on = [
    module.infra-aws.public_subnet_ids
  ]
  source  = "F5Networks/bigip-module/aws"
  version = "1.1.10"

  f5_ami_search_name = "F5 BIGIP-16.1.3.3* PAYG-Good 25Mbps*"
  ec2_instance_type  = "t3.medium"
  prefix             = "${var.prefix}new"
  ec2_key_name       = var.aws_key_pair_key_name
  mgmt_subnet_ids = [{ "subnet_id" = local.publicSubnet,
    "public_ip"          = true,
    "private_ip_primary" = ""
  }]
  mgmt_securitygroup_ids = [module.infra-aws.security_group_ssh_id]

  #updating to latest
  DO_URL   = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.36.0/f5-declarative-onboarding-1.36.0-4.noarch.rpm"
  AS3_URL  = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.43.0/f5-appsvcs-3.43.0-2.noarch.rpm"
  TS_URL   = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.32.0/f5-telemetry-1.32.0-2.noarch.rpm"
  CFE_URL  = "https://github.com/F5Networks/f5-cloud-failover-extension/releases/download/v1.13.0/f5-cloud-failover-1.13.0-0.noarch.rpm"
  FAST_URL = "https://github.com/F5Networks/f5-appsvcs-templates/releases/download/v1.24.0/f5-appsvcs-templates-1.24.0-1.noarch.rpm"
  INIT_URL = "https://github.com/F5Networks/f5-bigip-runtime-init/releases/download/1.5.2/f5-bigip-runtime-init-1.5.2-1.gz.run"

}


#hcp vault configuraiton - pki and kv and aws auth
module "hcp-vault-config" {
  source = "./modules/vault_config/"

  vault_fqdn          = local.vault_fqdn
  vault_token         = local.vault_token
  f5admin             = module.bigip.f5_username
  f5password          = module.bigip.bigip_password
  vault_bound_ami_ids = [module.infra-aws.bastion_ec2_ami_id]
}


module "tfc-agent" {
  source = "github.com/hashicorp-demo-lab/terraform-aws-tfc-agents-ecs"

  friendly_name_prefix = var.tfc_agent_prefix
  region               = var.aws_region
  vpc_id               = module.infra-aws.vpc_id
  subnet_ids           = module.infra-aws.private_subnet_ids
  tfc_agent_token      = var.tfc_agent_token
  tfc_agent_name       = var.tfc_agent_name
  tfc_agent_version    = var.tfc_agent_version
  agent_image          = "hashicorp/tfc-agent:latest"
  enable_logs          = true
}


resource "aws_route53_zone" "private_zone" {
  name = var.customer_domain
  vpc {
    vpc_id = module.infra-aws.vpc_id
  }
}

resource "aws_route53_record" "private_record_prod" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "prod.${var.customer_domain}"
  type    = "A"
  ttl     = "300"
  records = [
    "10.200.10.10"
  ]
}


resource "aws_route53_record" "private_record_dev" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "dev.${var.customer_domain}"
  type    = "A"
  ttl     = "300"
  records = [
    "10.200.10.11"
  ]
}





