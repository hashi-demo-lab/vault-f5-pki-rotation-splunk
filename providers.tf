terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.12.0"
    }

  }
}

provider "aws" {
  region = var.aws_region
}

provider "hcp" {

}

provider "vault" {
  address = local.vault_fqdn
  token   = local.vault_token
}

