



module "workspace" {
  source = "github.com/hashicorp-demo-lab/terraform-tfe-onboarding-module"

  organization          = "hashi-demos-apj"
  create_project        = true
  project_name          = "f5-project"
  workspace_name        = "f5virtualserverSSL"
  workspace_description = "virtualserverSSL example"
  workspace_agents      = true
  execution_mode        = "agent"
  agent_pool_name       = "SimonPool"
  vcs_repo = {
    "identifier" : "hashi-demo-lab/vault-f5-pki-rotation-splunk",
    "branch" : "main",
    "ingress_submodules" : null,
    "oauth_token_id" : "ot-EEzS6zKkh8tEBC7o"
  }
  workspace_vcs_directory = "F5virtual/virtualserverSSL"
  workspace_auto_apply    = true
  assessments_enabled     = true

}

resource "tfe_variable" "f5" {
  workspace_id = module.workspace.workspace_id

  key      = "f5_password"
  value    = "Hashicorp1!"
  category = "terraform"

  description = "f5"
}

resource "tfe_variable" "vault_adress" {
  workspace_id = module.workspace.workspace_id

  key      = "VAULT_ADDR"
  value    = var.vault_address
  category = "env"

  description = "Vault Address"
}

resource "tfe_variable" "f5_adress" {
  workspace_id = module.workspace.workspace_id

  key      = "f5_mgmtPublicDNS"
  value    = var.f5_mgmtPublicDNS
  category = "terraform"

  description = "f5 Address"
}


#### Dynamic Provider Credentials Vars

resource "tfe_variable" "enable_vault_provider_auth" {
  workspace_id = module.workspace.workspace_id

  key      = "TFC_VAULT_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for Vault."
}

resource "tfe_variable" "tfc_vault_addr" {
  workspace_id = module.workspace.workspace_id

  key       = "TFC_VAULT_ADDR"
  value     = var.vault_address
  category  = "env"
  sensitive = true

  description = "The address of the Vault instance runs will access."
}

resource "tfe_variable" "tfc_vault_role" {
  workspace_id = module.workspace.workspace_id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = var.vault_role
  category = "env"

  description = "The Vault role runs will use to authenticate."
}



resource "tfe_variable" "tfc_vault_namespace" {
  workspace_id = module.workspace.workspace_id

  key      = "TFC_VAULT_NAMESPACE"
  value    = var.vault_namespace
  category = "env"

  description = "The Vault namespace to use, if not using the default"
}
