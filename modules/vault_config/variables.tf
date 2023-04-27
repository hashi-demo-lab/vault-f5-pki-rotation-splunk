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
  default     = 600 #10 minutes
}



