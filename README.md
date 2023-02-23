# Vault-F5-PKI-Rotation-Splunk

Note: F5 VE takes approximately 2 minutes to spin up and receive API calls even after public address is returned

```sh
# Need to set HCP Credentials

export HCP_CLIENT_ID=""
export HCP_CLIENT_SECRET=""

```

```sh
# To handles dependencies target the HCP module first, to prevent Vault provider validation errors

terraform apply --auto-approve -target module.hcp-vault; terraform apply --auto-approve
```

```sh
# export environment variables, namespace is required for HCP

export VAULT_NAMESPACE=admin
export VAULT_ADDR='https://hcp-vault-demo-public-vault-7a4fb99b.6adbf943.z1.hashicorp.cloud:8200'
export VAULT_TOKEN=''
```

```sh
#AppRole - Get roleid and secret-id

vault read -format=json auth/approle/role/f5-device-role/role-id | jq -r '.data.role_id' > ../roleID
vault write -f -format=json auth/approle/role/f5-device-role/secret-id | jq -r '.data.secret_id' > ../secretID
```

```sh
#start Vault Agent with directory config using multiple agent templates

vault agent -config=/home/ubuntu/vault-f5-pki-rotation-splunk/vault_agent_config/
```
