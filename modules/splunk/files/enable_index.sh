#!/bin/sh
sudo tee -a /opt/splunk/etc/system/local/authorize.conf >/dev/null << 'EOF'
[role_admin]
srchMaxTime = 8640000
srchIndexesDefault = main;vault-audit;vault-metrics;hcp-vault-events
srchIndexesAllowed = *;_*;vault-audit;vault-metrics;hcp-vault-events
grantableRoles = admin
EOF

