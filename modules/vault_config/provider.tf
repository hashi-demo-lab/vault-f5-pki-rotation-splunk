provider "vault" {
  address = var.vault_fqdn
  token   = var.vault_token
  skip_tls_verify = true
  skip_get_vault_version = true
  skip_child_token = true
  }

