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
