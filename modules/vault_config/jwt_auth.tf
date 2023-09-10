resource "vault_jwt_auth_backend" "tfc_jwt" {
  path               = "jwt"
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"

  # If you are using TFE with custom / self-signed CA certs you may need to provide them via the
  # below argument as a string in PEM format.
  #
  # oidc_discovery_ca_pem = "my CA certs as PEM"
}


resource "vault_jwt_auth_backend_role" "tfc_role" {
  backend        = vault_jwt_auth_backend.tfc_jwt.path
  role_name      = "f5demo"
  token_policies = ["cert-policy"]

  bound_audiences   = ["vault.workload.identity"]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
  }
  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200
}