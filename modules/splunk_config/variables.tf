##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  #default = "user"
}

variable "email" {
  description = "your email address"
  default = "user@domain.com"
}

variable "splunk_domain" {
  description = "This is the url that will be created <value>.aws.hashidemos.io"
  default = "splunk"
}

variable "HCP_CLIENT_ID" {
  description = "hcp service principal for vault config"
}

variable "HCP_CLIENT_SECRET" {
  description = "hcp service principal secret"
}

variable "hcp_vault_cluster_id" {
  description = "hcp vault cluster id"
}

variable "hcp_vault_hvn" {
  description = "hcp vault hvn id"
}

variable "username" {
  description = "hashicorp username"
  default = "user"
}

variable "splunk_fqdn" {
  description = "splunk fqdn"
}

variable "hcp-vault-events" {
  description = "splunk events token"
}

variable "hcp-vault-audit" {
  description = "splunk audit token"
}