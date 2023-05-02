deployment_name       = "hcp-vault-pcarey1"
owner                 = "pcarey"
ttl                   = "300"
hcp_region            = "ap-southeast-2"
aws_region            = "ap-southeast-2"
ssh_pubkey            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDd7DM+YdLwGfNf+CdT0zw0sHpM8u+vn2N38JLIK1OzIE4TbaPvmrCcE7ghpU62qFoFUkVmTcg8nL5D+iHYY9dz9l3DpHVi3tq6AbnVD62Mq2DGFnoc0szUXFO1Qu/+O+qys4htIaZLOplrYGZZyebA8+zA59HtfPvnStWcnuvoGcx94jkTsGBTpl1KPF7XqZG9AQ+M8m2Wyj0FnxabIseP/MxCIKsQa1MhmjNBueAieJuaZ1b5eo2RLrdg5gX3ZZQZxOioFE2dxi6Bx8xctq6hwIgWK1iSPnuXOCEXCtm/lxxtA9qHmbPamPnQrgpVMctjhyRDri1+qixioj0iiKGhQbqYrRklEGuXKfylwv7jYWt6WYE3XwkHjx9ZHpFCEbCSWkrD5LdBWyKJrIX8/em9xtctt/4A4+IwQjhjSLtZqK05qNnc6MQU0Z56CFUX0GyVbjQV/BX9syHDCLxCqFutda9mj2TGJPNSdHZp1Dku/VMC6rCopDT4Y/DIdgW8NiU= pcarey@macbook-pro"
aws_key_pair_key_name = "pcarey-mac"

hcp_vault_tier        = "standard_small"
# terraform cloud workspace onboarding varables
organization = "hashi-demos-apj"
customername = "acme"
tfc_agent_token = "test123"

# F5 Variables
ingress_cidr_blocks = ["202.137.173.136/32"]
