resource "vault_generic_endpoint" "pki" {
  path = "${var.pki_intermediate_path}/issue/${var.pki_role}"
  disable_delete = true
  write_fields = ["ca_chain","certificate","expiration","private_key","private_key_type"]
  disable_read = true
  data_json = <<EOT
  {
    "common_name": "${var.common_name}"
  }
  EOT
} 


locals {
  trimPrivate = trim(vault_generic_endpoint.pki.write_data.private_key,"\n")
  trimCert = trim(vault_generic_endpoint.pki.write_data.certificate,"\n")
  full = jsondecode(vault_generic_endpoint.pki.write_data_json)
  trim_ca_chain = trim(local.full.ca_chain[0],"\n")
}

output "ca_chain" {
  value = local.full.ca_chain[0]
}

resource "bigip_ssl_key" "my_key" {
  name      = "${var.app_prefix}.key"
  content   = local.trimPrivate
  partition = var.f5_partition
}

resource "bigip_ssl_certificate" "my_cert" {
  name      = "${var.app_prefix}.crt"
  content   = local.trimCert
  partition = var.f5_partition
}

resource "bigip_ssl_certificate" "my_chain" {
  name      = "${var.app_prefix}cabundle.crt"
  content   = local.trim_ca_chain
  partition = var.f5_partition
} 

resource "bigip_ltm_profile_client_ssl" "my_profile" {
  name           = "/${var.f5_partition}/clientssl_${var.app_prefix}"
  defaults_from  = "/Common/clientssl"
  cert_key_chain {
    name  = bigip_ssl_certificate.my_cert.name
    cert  = "/${var.f5_partition}/${bigip_ssl_certificate.my_cert.name}"
    key   = "/${var.f5_partition}/${bigip_ssl_key.my_key.name}"
    chain = "/${var.f5_partition}/${bigip_ssl_certificate.my_chain.name}"
  }
}

#LTM Pool and node attachment
resource "bigip_ltm_pool" "pool" {
  name                = "/Common/${var.app_prefix}_pool"
  load_balancing_mode = "round-robin"
  monitors            = []
  allow_snat          = "yes"
  allow_nat           = "yes"
}

resource "bigip_ltm_node" "node" {
  for_each = toset(var.node_list)
  name    = "/Common/${each.value}"
  address = each.value
}

resource "bigip_ltm_pool_attachment" "attach_node" {
  for_each = bigip_ltm_node.node
  pool = bigip_ltm_pool.pool.name
  node = "${bigip_ltm_node.node[each.key].name}:80"
}


# Create F5 virtual server
resource "bigip_ltm_virtual_server" "https" {
  name = "/Common/${var.app_prefix}_vs_https"
  destination = "${var.vip_ip}"
  port = 443
  pool = bigip_ltm_pool.pool.name
  profiles = []
  source_address_translation = "automap"
} 