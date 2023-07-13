resource "vault_pki_secret_backend_cert" "this" {
  backend = var.pki_intermediate_path
  name    = var.pki_role

  common_name           = var.common_name
  min_seconds_remaining = "1209600" # 14 days - example only
  auto_renew            = var.auto_renew

  lifecycle {
    postcondition {
      condition = !self.renew_pending
      error_message = "${var.common_name} - min remaining time reached. F5 Vault cert should be renewed."
    }
  }
}