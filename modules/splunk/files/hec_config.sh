#!/bin/sh
sudo /opt/splunk/bin/splunk add index vault-audit \
    -homePath /opt/splunk/var/lib/splunk/vault-audit/db \
    -coldPath /opt/splunk/var/lib/splunk/vault-audit/colddb \
    -thawedPath /opt/splunk/var/lib/splunk/vault-audit/thaweddb \
    -datatype event

sudo /opt/splunk/bin/splunk add index hcp-vault-events \
    -homePath /opt/splunk/var/lib/splunk/hcp-vault-events/db \
    -coldPath /opt/splunk/var/lib/splunk/hcp-vault-events/colddb \
    -thawedPath /opt/splunk/var/lib/splunk/hcp-vault-events/thaweddb \
    -datatype event

sudo /opt/splunk/bin/splunk add index vault-metrics \
    -homePath /opt/splunk/var/lib/splunk/vault-metrics/db \
    -coldPath /opt/splunk/var/lib/splunk/vault-metrics/colddb \
    -thawedPath /opt/splunk/var/lib/splunk/vault-metrics/thaweddb \
    -datatype metric

sudo /opt/splunk/bin/splunk http-event-collector create vault-audit \
      -uri https://localhost:8089 \
      -description "Vault file audit device log" \
      -disabled 0 \
      -index vault-audit \
      -indexes vault-audit \
      -sourcetype vault_audit_log \
      -token 12b8a76f-3fa8-4d17-b67f-78d794f042fb

sudo /opt/splunk/bin/splunk http-event-collector create hcp-vault-events \
      -uri https://localhost:8089 \
      -description "HCP Vault Metric Events" \
      -disabled 0 \
      -index hcp-vault-events \
      -indexes hcp-vault-events \
      -sourcetype hcp_vault_events_log \
      -token 12b8a76f-3fa8-4d17-b67f-78d794f04abc

sudo /opt/splunk/bin/splunk http-event-collector create vault-metrics \
      -uri https://localhost:8089 \
      -description "Vault telemetry metrics" \
      -disabled 0 \
      -index vault-metrics \
      -indexes vault-metrics \
      -sourcetype hashicorp_vault_telemetry \
      -token 42c0ff33-c00l-7374-87bd-690ac97efc50

