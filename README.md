# Vault-F5-PKI-Rotation-Splunk

```sh

# Need to set HCP Credentials

export HCP_CLIENT_ID=""
export HCP_CLIENT_SECRET=""
```

This deployment takes approximately 12 minutes to fully deploy all components.

Note: Post successful apply the F5 VE takes approximately 2 minutes to startup up and initialise to a state ready receive API calls even after public address is returned.

```sh
# To handles dependencies target the HCP module first, to prevent Vault provider validation errors

terraform apply --auto-approve -target module.hcp-vault -target module.splunk; terraform apply --auto-approve
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

Prerequites for remote connection for X11 over SSH

We use a remote bastion with desktop for showing certificate rotation with F5 virtual server connectivity with private hosted DNS resolution

```sh
brew install --cask xquartz
brew install --cask x2goclient
```
