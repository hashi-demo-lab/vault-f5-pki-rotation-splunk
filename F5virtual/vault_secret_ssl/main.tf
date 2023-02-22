
data "vault_generic_secret" "pki" {
  # example pki vault role path - pki_intermediate/issue/f5demo
  path = "${var.pki_intermediate_path}/issue/${var.pki_role}"

}

output "secret_json" {
    value = data.vault_generic_secret.pki.data_json
  
}