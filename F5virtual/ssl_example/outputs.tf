output "renew_pending" {
  value = vault_pki_secret_backend_cert.this.renew_pending
  description = "certificate renewal status"
}