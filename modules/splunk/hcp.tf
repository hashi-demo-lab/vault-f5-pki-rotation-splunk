#provider "hcp" {
  #client_id     = var.HCP_CLIENT_ID
#  client_secret = var.HCP_CLIENT_SECRET
#}

#data "hcp_vault_cluster" "example" {
#  cluster_id = var.hcp_vault_cluster_id
#}
/*
data "hcp_hvn" "example" {
  hvn_id = var.hcp_vault_hvn
}

locals {
  user_name = var.prefix # the user-name part of your @hashicorp.com email address
}
data "aws_route53_zone" "me_aws_sbx_hashicorpdemo_com" {
  name = format("%s.aws.sbx.hashicorpdemo.com", replace(local.user_name, ".", "-"))
}
data "aws_route53_zone" "me_sbx_hashidemos_io" {
  name = format("%s.sbx.hashidemos.io", replace(local.user_name, ".", "-"))
}
*/