



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



resource "tfe_variable" "tfc_azure_client_id" {
  workspace_id = module.workspace.workspace_id

  key      = "TFC_AZURE_RUN_CLIENT_ID"
  value    = ""
  category = "env"

  description = "The Azure Client ID runs will use to authenticate."
}

