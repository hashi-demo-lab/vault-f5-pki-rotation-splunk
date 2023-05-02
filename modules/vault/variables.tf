variable "deployment_name" {
  description = "Deployment name, used to prefix resources"
  type        = string
}

variable "hvn_id" {
  description = "HVN id"
  type        = string
}

variable "tier" {
  description = "Vault cluster tier"
  type        = string
}

variable "hcp-vault-audit" {
  description = "Vault audit token"
  type        = string
}

variable "hcp-vault-events" {
  description = "Vault events token"
  type        = string
}

variable "splunk_fqdn" {
  description = "fqdn to send vault metrics to"
  
}