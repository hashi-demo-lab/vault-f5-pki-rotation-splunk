output "admin_token" {
  value     = hcp_vault_cluster_admin_token.token.token
  sensitive = true
}

output "public_endpoint_url" {
  value = hcp_vault_cluster.vault.vault_public_endpoint_url
}