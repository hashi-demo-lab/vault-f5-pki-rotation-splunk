

locals {
  hcp_vault_public_fqdn = module.hcp-vault.public_endpoint_url
  vault_token           = module.hcp-vault.admin_token

}


#Separate mounts for root and intermediate

resource "vault_mount" "pki-example" {
  depends_on = [
    local.hcp_vault_public_fqdn
  ]

  path        = "pki"
  type        = "pki"
  description = "This is an example PKI mount"

  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}
