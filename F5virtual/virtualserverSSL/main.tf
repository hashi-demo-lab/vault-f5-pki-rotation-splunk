resource "vault_pki_secret_backend_cert" "this" {
  backend = "pki_intermediate"
  name    = "f5demo" # role name

  common_name           = var.common_name
  min_seconds_remaining = "1209600"
  auto_renew            = true
}


resource "bigip_ssl_key" "key" {
  name      = "${var.app_prefix}${vault_pki_secret_backend_cert.this.expiration}.key"
  content   = local.trimPrivate
  partition = var.f5_partition

  lifecycle {
    create_before_destroy = true
  }
}

resource "bigip_ssl_certificate" "cert" {
  name      = "${var.app_prefix}${vault_pki_secret_backend_cert.this.expiration}.crt"
  content   = local.trimCert
  partition = var.f5_partition
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "bigip_ssl_certificate" "chain" {
  name      = "${var.app_prefix}${vault_pki_secret_backend_cert.this.expiration}cabundle.crt"
  content   = local.trim_ca_chain
  partition = var.f5_partition

  lifecycle {
    create_before_destroy = true
  }
}


resource "bigip_ltm_profile_client_ssl" "profile" {
  name          = "/${var.f5_partition}/clientssl_${var.app_prefix}"
  defaults_from = "/Common/clientssl"
  cert          = "/${var.f5_partition}/${bigip_ssl_certificate.cert.name}"
  key           = "/${var.f5_partition}/${bigip_ssl_key.key.name}"
  chain         = "/${var.f5_partition}/${bigip_ssl_certificate.chain.name}"
}

#LTM Pool and node attachment
resource "bigip_ltm_pool" "pool" {
  name                = "/Common/${var.app_prefix}_pool"
  load_balancing_mode = "round-robin"
  monitors            = ["/Common/http"]
  allow_snat          = "yes"
  allow_nat           = "yes"
}

resource "bigip_ltm_node" "node" {
  for_each = toset(var.node_list)
  name     = "/Common/${each.value}"
  address  = each.value
  monitor = "/Common/none"
}

resource "bigip_ltm_pool_attachment" "attach_node" {
  for_each = bigip_ltm_node.node
  pool     = bigip_ltm_pool.pool.name
  node     = "${bigip_ltm_node.node[each.key].name}:80"
}


# Create F5 virtual server
resource "bigip_ltm_virtual_server" "https" {
  name                       = "/Common/${var.app_prefix}_vs_https"
  destination                = var.vip_ip
  port                       = 443
  pool                       = bigip_ltm_pool.pool.name
  client_profiles            = [bigip_ltm_profile_client_ssl.profile.name]
  source_address_translation = "automap"
}


output "vault_cert" {
  value     = local.trimCert
}

output "vault_cert_serial" {
  value = local.vault_cert
}

output "vault_cert_sha1" {
  value = local.sha1_vault_cert
}

output "f5_lb_certs_tls_datasource" {
  value = local.lb_cert
}

### Validation Example

locals {

}

data "tls_certificate" "this" {
  depends_on = [
    vault_pki_secret_backend_cert.this
  ]

  url = "https://${var.common_name}"
  verify_chain = false

 /*  lifecycle {
    postcondition {
      condition     = self.certificates[0].serial_number == local.vault_cert
      error_message = "Certificate serial numbers do not match for ${var.f5_partition}/${bigip_ssl_certificate.cert.name}"
    }
  } */
} 




locals {
  trimPrivate   = trim(vault_pki_secret_backend_cert.this.private_key, "\n")
  trimCert      = trim(vault_pki_secret_backend_cert.this.certificate, "\n")
  trim_ca_chain = trim(vault_pki_secret_backend_cert.this.ca_chain, "\n")
  sha1_vault_cert = sha1(local.trimCert)
  vault_cert = replace(vault_pki_secret_backend_cert.this.serial_number, ":", "")
  lb_cert = data.tls_certificate.this.certificates
}
