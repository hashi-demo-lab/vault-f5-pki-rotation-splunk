terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }

    vault = {
      source = "hashicorp/vault"
      version = "3.12.0"
    }

  }
}

provider "aws" {
  region = var.aws_region
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

provider "vault" {
  address = local.hcp_vault_public_fqdn
  token = local.vault_token
  
}

