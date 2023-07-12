data "aws_route53_zone" "sbx_hashidemos_io" {
  name = "${var.prefix}.aws.sbx.hashicorpdemo.com"
}


resource "aws_route53_record" "splunk" {
  zone_id = data.aws_route53_zone.sbx_hashidemos_io.zone_id
  name    = "${var.splunk_domain}.${var.prefix}.aws.sbx.hashicorpdemo.com"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.splunk.public_ip]
}
