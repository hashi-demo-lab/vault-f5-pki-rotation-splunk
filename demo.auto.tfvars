deployment_name       = "hcp-vault-demo"
owner                 = "srlynch"
ttl                   = "300"
hcp_region            = "ap-southeast-2"
aws_region            = "ap-southeast-2"
ssh_pubkey            = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII8wNgHtY1Lao00trZ8XoweIxa4F9T/wekoP2e2VzZPq simon.lynch@hashicorp.com"
#ssh_pubkey            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOL7uceFyeKxFV/uH7va5ZUhYaFOuoNxY9fUrJtMxRfUewJ0INuQPoGvqmu2oOJVo+jz5tLDJGDl49TifEIUczIDIrVIVnYgwCL3aIUsiJPGPrjfqEtiwJMVc6ebePdxMOKFccxqShE1lQNNeu0iZThSYjpxC8d30+ZaXNGrENNTijhWHows7gQE5TVv2Dqu63hHlaipuuFo03PQuiLiqvPaMeByQi8XztYk5na+dHUmNGkwqHYqLrBIJhZnVfmdXBNNEwoW7T2fUg9MSm3DHlRp2wvDK07zj+TW/03YRCFiPhEMidXpybbEa3FtiC1QW3E3hOobOKDNsYbZS9M06/Tjg0uNW3cOFOwz/aEzAi+ZFm0fUV7uU9hkD5zinvyBgimIVkTBZVTpdgENcPRgjyWJj0mi7jJ1cbnwC90BE7wJGg1EkSAQTKb2wG9qzI85VNBtUZ8cAg+wOWnl4SkK50ZQucWoBFFI46vI/rQLfLU9rDMINN0FMxcI84q0+SxHc= simon.lynch@simon.lynch-TLYHK3HJGJ"
aws_key_pair_key_name = "awsf5demo"

# terraform cloud workspace onboarding varables
organization = "hashi-demos-apj"
customername = "acme"


#your public IP address range to allow inbound
ingress_cidr_blocks = ["124.169.52.211/32", "202.137.173.136/32"]


