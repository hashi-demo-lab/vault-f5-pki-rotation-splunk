// generic outputs

output "deployment_id" {
  description = "Deployment identifier"
  value       = local.deployment_id
}

// amazon web services (aws) outputs

output "aws_bastion_public_fqdn" {
  description = "AWS public fqdn of bastion node"
  value       = module.infra-aws.bastion_public_fqdn
}

// hashiCorp cloud platform (hcp) outputs

output "hcp_vault_admin_token" {
  description = "HCP vault admin token"
  value       = module.hcp-vault.admin_token
  sensitive   = true
}

output "hcp_vault_public_fqdn" {
  description = "HCP vault public fqdn"
  value       = module.hcp-vault.public_endpoint_url
}