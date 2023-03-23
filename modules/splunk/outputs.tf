
output "splunk_url" {
  value = "https://${aws_route53_record.splunk.fqdn}:8000"
}

# The rest of the outputs might only be required for debugging. In which case comment them out as required. 

# output "splunk_eip_aws" {
#   value = "https://${aws_eip.splunk.public_dns}:8000"
# }

# output "splunk_ip" {
#   value = "http://${aws_eip.splunk.public_ip}"
# }

# important dns outputs
# output "aws_sub_zone_id" {
#   value = module.dns.aws_sub_zone_id
# }

# output "aws_zone_record" {
#   value = aws_route53_record.splunk.fqdn
#}

# output "certificate_url" {
#   value = acme_certificate.certificate.certificate_url
# }

# output "private_key" {
#   value = nonsensitive(acme_certificate.certificate.private_key_pem)
# }

# output "certificate_pem" {
#   value = acme_certificate.certificate.certificate_pem
# }

# output "certificate_fullchain" {
#   value = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"
# }
