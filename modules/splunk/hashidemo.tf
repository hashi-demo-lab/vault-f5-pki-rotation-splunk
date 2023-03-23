# Use the DNS module to create the required zones in AWS only
module "dns" { 
  source = "github.com/chuysmans/dns-multicloud"
  hosted-zone = "hashidemos.io"
   namespace   = var.prefix                  # HashiCorp username
   owner       = var.prefix                  # HashiCorp email (no @ symbol)
   create_aws_dns_zone   = true              # should be set to true
}

# Update DNS name
resource "aws_route53_record" "splunk" {
  zone_id = module.dns.aws_sub_zone_id
  name    = "${var.splunk_domain}.aws.hashidemos.io"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.splunk.public_ip]
}
