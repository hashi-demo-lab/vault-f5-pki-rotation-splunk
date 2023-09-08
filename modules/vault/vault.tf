resource "hcp_vault_cluster" "vault" {
  hvn_id          = var.hvn_id
  cluster_id      = var.deployment_name
  tier            = var.tier
  public_endpoint = true

/*   metrics_config {
    splunk_hecendpoint = "https://${var.splunk_fqdn}:8088"
    splunk_token  = var.hcp-vault-events
  }
  audit_log_config {
    splunk_hecendpoint = "https://${var.splunk_fqdn}:8088"
    splunk_token  = var.hcp-vault-audit
  } */
}

resource "hcp_vault_cluster_admin_token" "token" {
  cluster_id = var.deployment_name

  depends_on = [
    hcp_vault_cluster.vault
  ]
}