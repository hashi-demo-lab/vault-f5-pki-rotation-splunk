locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

// terraform cloud workspace onboarding

/* module "tfc-workspace-onboarding" {
  source = "github.com/hashicorp-demo-lab/terraform-tfe-onboarding-module"

  organization                  = var.organization
  create_project                = var.create_project
  project_name                  = var.project_name
  workspace_name                = var.workspace_name
  workspace_description         = var.workspace_description
  workspace_terraform_version   = var.workspace_terraform_version
  workspace_tags                = var.workspace_tags
  variables                     = var.variables
  remote_state                  = var.remote_state
  remote_state_consumers        = var.remote_state_consumers
  vcs_repo                      = var.vcs_repo
  workspace_vcs_directory       = var.workspace_vcs_directory
  workspace_auto_apply          = var.workspace_auto_apply
  workspace_agents              = var.workspace_agents
  execution_mode                = var.execution_mode
  agent_pool_name               = var.agent_pool_name
  assessments_enabled           = var.assessments_enabled
  workspace_read_access_emails  = var.workspace_read_access_emails
  workspace_write_access_emails = var.workspace_write_access_emails
  workspace_plan_access_emails  = var.workspace_plan_access_emails
} */

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
  ssh_pubkey = var.ssh_pubkey
  aws_key_pair_key_name = var.aws_key_pair_key_name
}

// hcp vault

module "hcp-vault" {
  source = "./modules/vault/"

  deployment_name = var.deployment_name
  hvn_id          = module.hcp-hvn.id
  tier            = var.hcp_vault_tier
}


locals {
  publicSubnet = tolist(module.infra-aws.public_subnet_ids)[0]
  
}

module bigip {

  depends_on = [
    module.infra-aws
  ]

  source                 = "F5Networks/bigip-module/aws"
  version = "1.1.10"

  f5_ami_search_name = "F5 BIGIP-16.1.3.3* PAYG-Good 25Mbps*"
  
  prefix                 = var.prefix
  ec2_key_name           = var.aws_key_pair_key_name
  mgmt_subnet_ids        = [{ "subnet_id" = local.publicSubnet,
                              "public_ip" = true, 
                              "private_ip_primary" = ""
                            }]                    
  mgmt_securitygroup_ids = [module.infra-aws.security_group_ssh_id]

  #updating to latest
  DO_URL = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.36.0/f5-declarative-onboarding-1.36.0-4.noarch.rpm"
  AS3_URL = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.43.0/f5-appsvcs-3.43.0-2.noarch.rpm"
  TS_URL = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.32.0/f5-telemetry-1.32.0-2.noarch.rpm"
  CFE_URL = "https://github.com/F5Networks/f5-cloud-failover-extension/releases/download/v1.13.0/f5-cloud-failover-1.13.0-0.noarch.rpm"
  FAST_URL = "https://github.com/F5Networks/f5-appsvcs-templates/releases/download/v1.24.0/f5-appsvcs-templates-1.24.0-1.noarch.rpm"
  INIT_URL= "https://github.com/F5Networks/f5-bigip-runtime-init/releases/download/1.5.2/f5-bigip-runtime-init-1.5.2-1.gz.run"

}