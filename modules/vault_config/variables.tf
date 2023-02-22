variable "customername" {
  description = "Customer Demo Name"
  type        = string
  default     = "acme"
}

variable "vault_fqdn" {
  description = "vault fqdn"
  type = string
  default = ""
  sensitive = true
}

variable "vault_token" {
  description = "vault token"
  type = string
  default = ""
  sensitive = true
}


variable "f5admin" {
  description = "F5 admin username"
  type = string
  default = "bigipuser"
  sensitive = true
}

variable "f5password" {
  description = "F5 API password"
  type = string
  default = ""
  sensitive = true
}

variable "var.cert_ttl_seconds" {
  description = "value"
  type = string
  default = 600 #10 minutes
}

