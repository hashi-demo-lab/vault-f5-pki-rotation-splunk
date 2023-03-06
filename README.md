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

set environment variables

```sh
export VAULT_NAMESPACE=admin
export VAULT_ADDR='https://hcp-vault-demo-public-vault-7a4fb99b.6adbf943.z1.hashicorp.cloud:8200'
export VAULT_TOKEN=''
```

From Bastion host
SSH to Bastion and start Vault Agent

```sh
cd /tmp
sh startVaultAgent.sh
```
