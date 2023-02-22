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

resource "bigip_ssl_certificate" "myapp" {
  name      = "${var.app_prefix}-myapp.crt"
  content   = chomp(vault_generic_endpoint.pki.write_data.certificate)
  partition = "Common"
}

resource "bigip_ssl_key" "app4key" {
  name      = "${var.app_prefix}-myapp.key"
  content   = chomp(vault_generic_endpoint.pki.write_data.private_key)
  partition = "Common"
}

resource "bigip_fast_https_app" "this" {
  application               = "${var.app_prefix}-myapp"
  tenant                    = "scenario4"
  virtual_server            {
    ip                        = "10.1.10.224"
    port                      = 443
  }
  tls_server_profile {
    tls_cert_name             = "/Common/${var.app_prefix}-myapp.crt"
    tls_key_name              = "/Common/${var.app_prefix}-myapp.key"
  }
  pool_members  {
    addresses                 = ["10.1.10.120", "10.1.10.121", "10.1.10.122"]
    port                      = 80
  }
  snat_pool_address = ["10.1.10.50", "10.1.10.51", "10.1.10.52"]
  load_balancing_mode       = "least-connections-member"
  depends_on          = [bigip_ssl_certificate.myapp, bigip_ssl_key.myapp]
}