#!/bin/bash
curl -X POST --silent --insecure -u admin:W3lcome098! -H 'Content-Type: application/json' -d @certmanagement.json https://192.168.86.245/mgmt/shared/appsvcs/declare | jq
