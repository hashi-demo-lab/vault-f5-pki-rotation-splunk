deployment_name       = "hcp-vault-f5"
owner                 = "simon-lynch-2281"
ttl                   = "300"
hcp_region            = "ap-southeast-2"
aws_region            = "ap-southeast-2"
ssh_pubkey            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOL7uceFyeKxFV/uH7va5ZUhYaFOuoNxY9fUrJtMxRfUewJ0INuQPoGvqmu2oOJVo+jz5tLDJGDl49TifEIUczIDIrVIVnYgwCL3aIUsiJPGPrjfqEtiwJMVc6ebePdxMOKFccxqShE1lQNNeu0iZThSYjpxC8d30+ZaXNGrENNTijhWHows7gQE5TVv2Dqu63hHlaipuuFo03PQuiLiqvPaMeByQi8XztYk5na+dHUmNGkwqHYqLrBIJhZnVfmdXBNNEwoW7T2fUg9MSm3DHlRp2wvDK07zj+TW/03YRCFiPhEMidXpybbEa3FtiC1QW3E3hOobOKDNsYbZS9M06/Tjg0uNW3cOFOwz/aEzAi+ZFm0fUV7uU9hkD5zinvyBgimIVkTBZVTpdgENcPRgjyWJj0mi7jJ1cbnwC90BE7wJGg1EkSAQTKb2wG9qzI85VNBtUZ8cAg+wOWnl4SkK50ZQucWoBFFI46vI/rQLfLU9rDMINN0FMxcI84q0+SxHc= simon.lynch@simon.lynch-TLYHK3HJGJ"
aws_key_pair_key_name = "f5demo"

hcp_vault_tier = "standard_small"
# terraform cloud workspace onboarding varables
organization    = "hashi-demos-apj"
customername    = "acme"
tfc_agent_token = "sometoken"

# F5 Variables
ingress_cidr_blocks = ["163.53.144.90/32"]
