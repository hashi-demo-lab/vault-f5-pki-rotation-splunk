terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.13.0"
    }
  }
}

provider "vault" {
  namespace = "admin"
}

locals {
  certificate = data.tls_certificate.this.certificates[0].serial_number
  #element(data.tls_certificate.this.certificates, length(data.tls_certificate.this.certificates)-1).serial_number 

  vault_cert = replace(vault_pki_secret_backend_cert.this.serial_number, ":", "")

  certificates = data.tls_certificate.this.certificates
}



data "tls_certificate" "this" {
    url = "https://registry.terraform.io"
    depends_on = [
      resource.vault_pki_secret_backend_cert.this
    ]

     lifecycle {
        postcondition {
            condition     =  anytrue([
              for item in self.certificates : contains([local.vault_cert], item.serial_number)
            ])
            error_message = "Certificate serial numbers do not match"
       }
    }  
}

resource "vault_pki_secret_backend_cert" "this" {
    backend = "pki_intermediate"
    name = "f5demo" # role name

    common_name = "dev.f5demo.com"
    min_seconds_remaining = "604800"
    auto_renew = true
}


output "certificate" {
  value = local.certificate 
}


output "certificates" {
  value = local.certificates
}

