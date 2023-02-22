resource "vault_generic_endpoint" "pki" {
  path = "${var.pki_intermediate_path}/issue/${var.pki_role}"
  disable_read = true
  write_fields = [  ]
  data_json = <<EOT
  {
    "common_name": "${var.common_name}"
  }
  EOT

} 


resource "bigip_ssl_certificate" "app4crt" {
  name      = "app4.crt"
  content   = vault_generic_endpoint.pki.write_data_json
  partition = "Common"
}

resource "bigip_ssl_key" "app4key" {
  name      = "app4.key"
  content   = file("app4.key")
  partition = "Common"
}

resource "bigip_fast_https_app" "this" {
  application               = "myApp4"
  tenant                    = "scenario4"
  virtual_server            {
    ip                        = "10.1.10.224"
    port                      = 443
  }
  tls_server_profile {
    tls_cert_name             = "/Common/app4.crt"
    tls_key_name              = "/Common/app4.key"
  }
  pool_members  {
    addresses                 = ["10.1.10.120", "10.1.10.121", "10.1.10.122"]
    port                      = 80
  }
  snat_pool_address = ["10.1.10.50", "10.1.10.51", "10.1.10.52"]
  load_balancing_mode       = "least-connections-member"
  monitor       {
    send_string               = "GET / HTTP/1.1\\r\\nHost: example.com\\r\\nConnection: Close\\r\\n\\r\\n"
    response                  = "200 OK"
  }
  depends_on          = [bigip_ssl_certificate.app4crt, bigip_ssl_key.app4key]
}