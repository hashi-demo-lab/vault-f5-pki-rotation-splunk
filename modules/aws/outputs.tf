output "vpc_id" {
  description = "VPC id"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet ids"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "Private subnet ids"
  value       = module.vpc.private_subnets
}

output "security_group_public_id" {
  description = "Security group public id"
  value       = module.sg-mgmt.security_group_id
}

output "security_group_private_id" {
  description = "Security group private id"
  value       = module.sg-private.security_group_id
}


output "tgw_id" {
  value = module.tgw.ec2_transit_gateway_id
}

output "ram_resource_share_arn" {
  value = module.tgw.ram_resource_share_id
}

output "bastion_public_fqdn" {
  description = "Public fqdn of bastion"
  value       = aws_eip.main.public_dns
}

output "bastion_ec2_instance_id" {
  description = "ec2 instance id"
  value = aws_instance.bastion.id
}

output "bastion_ec2_ami_id" {
  description = "ec2 instance id"
  value = aws_instance.bastion.ami
}