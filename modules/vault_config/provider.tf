provider "vault" {
  address            = var.vault_fqdn
  token              = var.vault_token
  add_address_to_env = true
  #skip_child_token = true
}

