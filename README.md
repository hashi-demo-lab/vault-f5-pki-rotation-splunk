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
