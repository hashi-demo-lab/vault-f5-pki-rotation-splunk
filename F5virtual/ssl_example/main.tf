resource "vault_pki_secret_backend_cert" "this" {
  backend = var.pki_intermediate_path
  name    = var.pki_role

  common_name           = var.common_name
  min_seconds_remaining = var.min_seconds_remaining
  auto_renew            = var.auto_renew

/*   lifecycle {
    postcondition {
      condition = !self.renew_pending
      error_message = "${var.common_name} - min remaining time reached. F5 Vault cert should be renewed."
    }
  } */
}

locals {
  certificate_renew_pending = vault_pki_secret_backend_cert.this.renew_pending
}

check "certificate" {
  assert {
    condition     = !local.certificate_renew_pending
    
    error_message = <<-EOF
    Certificate Renewal Pending: ${vault_pki_secret_backend_cert.this.common_name}
    EOF
  }
}

