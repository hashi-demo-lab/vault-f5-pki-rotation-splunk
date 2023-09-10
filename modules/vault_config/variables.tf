variable "customername" {
  description = "Customer Demo Name"
  type        = string
  default     = "acme"
}

variable "vault_fqdn" {
  description = "vault fqdn"
  type        = string
  default     = "https://hcp-vault-pcarey-public-vault-dce1423e.b5cdbc76.z1.hashicorp.cloud:8200"
  sensitive   = true
}

variable "vault_token" {
  description = "vault token"
  type        = string
  default     = "hvs.CAESIAYVFnPKPUwqEFhXlOjOUrPTxTxh4Lidi76xxYqCRb3KGicKImh2cy41TGQzbFRHS2lXMHludjdTVVB1bHdLQzcuVDU1V1YQ5gI"
  sensitive   = true
}

variable "vault_bound_ami_ids" {
  description = "AWS auth bound instance ids"
  type        = list(string)
  default     = []
}


variable "f5admin" {
  description = "F5 admin username"
  type        = string
  default     = "bigipuser"
  sensitive   = true
}

variable "f5password" {
  description = "F5 API password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "cert_ttl_seconds" {
  description = "value"
  type        = number
  default     = 1728000 #20 days
}


## JWT Vault backed dynamic creds
variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with Vault"
}

variable "tfc_organization_name" {
  type        = string
  default = "hashi-demos-apj"
  description = "The name of your Terraform Cloud organization"
}

variable "tfc_project_name" {
  type        = string
  default     = "f5-project"
  description = "The project under which a workspace will be created"
}

variable "tfc_workspace_name" {
  type        = string
  default     = "f5virtualserverSSL"
  description = "The name of the workspace that you'd like to create and connect to Vault"
}
