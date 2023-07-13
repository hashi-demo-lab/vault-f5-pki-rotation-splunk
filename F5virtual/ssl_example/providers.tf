terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.18.0"
    }
  }
}

provider "vault" {
  namespace = "admin"
}