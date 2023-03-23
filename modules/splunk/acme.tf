provider "acme" {
  # production
    server_url = "https://acme-v02.api.letsencrypt.org/directory"
  # staging
  #  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = "${tls_private_key.private_key.private_key_pem}"
  email_address   = var.email
}

resource "acme_certificate" "certificate" {
  account_key_pem           = "${acme_registration.reg.account_key_pem}"
  common_name               = "${var.splunk_domain}.aws.hashidemos.io"
  subject_alternative_names = ["${var.splunk_domain}.aws.hashidemos.io"]

  dns_challenge {
    provider = "route53"
  }

  depends_on = [
    aws_route53_record.splunk
  ]
}

resource "local_sensitive_file" "private_key_file" {
  content = acme_certificate.certificate.private_key_pem
  filename = "${path.module}/files/mySplunkWebPrivateKey.key"
}

resource "local_file" "certificate_chain" {
  content = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"
  filename = "${path.module}/files/mySplunkWebCertificate.pem"
}

resource "local_sensitive_file" "hec_certificate" {
  content = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.private_key_pem}${acme_certificate.certificate.issuer_pem}"
  filename = "${path.module}/files/server.pem"
}




