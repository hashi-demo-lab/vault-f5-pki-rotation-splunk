provider "splunk" {
  #url                  = "${aws_route53_record.splunk.fqdn}:8089"
  url = "${var.splunk_fqdn}:8089"
  username             = "admin"
  password             = "Splunksecurepassword123"
#  Debug only.
#  insecure_skip_verify = true
}

resource "random_uuid" "hcp-vault-events" {
}

resource "random_uuid" "hcp-vault-audit" {
}

resource "random_uuid" "vault-metrics" {
}

data "hcp_hvn" "example" {
  hvn_id = var.hcp_vault_hvn
}

resource "splunk_inputs_http_event_collector" "hcp-vault-events-tf" {
  name       = "hcp-vault-events-tf"
  index      = "hcp-vault-events"
  indexes    = ["hcp-vault-events"]
  #  source     = "new:source"
  sourcetype = "hcp_vault_events_log"
  disabled   = false
  use_ack    = 0
  token = var.hcp-vault-events

}

resource "splunk_inputs_http_event_collector" "hcp-vault-audit-tf" {
  name       = "hcp-vault-audit-tf"
  index      = "vault-audit"
  indexes    = ["vault-audit"]
  #  source     = "new:source"
  sourcetype = "vault_audit_log"
  disabled   = false
  use_ack    = 0
  token = var.hcp-vault-audit

}

resource "splunk_indexes" "hcp-vault-events" {
  name                   = "hcp-vault-events"
  datatype               = "event"
  max_hot_buckets        = 6
  max_total_data_size_mb = 1000000
}

resource "splunk_indexes" "hcp-vault-audit" {
  name                   = "vault-audit"
  datatype               = "event"
  max_hot_buckets        = 6
  max_total_data_size_mb = 1000000
}

resource "splunk_indexes" "vault-metrics" {
  name                   = "vault-metrics"
  datatype               = "metric"
  max_hot_buckets        = 6
  max_total_data_size_mb = 1000000
}

resource "splunk_global_http_event_collector" "http" {
  disabled   = false
  enable_ssl = true
  port       = 8088
}
