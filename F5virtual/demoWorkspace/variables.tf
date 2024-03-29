variable "vault_address" {
  type    = string
  default = "https://hcp-vault-f5-public-vault-3533a670.3c6186a9.z1.hashicorp.cloud:8200"
}

variable "f5_mgmtPublicDNS" {
  type    = string
  default = ""
}

variable "vault_role" {
  type    = string
  default = "f5demo"
}

variable "vault_namespace" {
  type    = string
  default = ""
}