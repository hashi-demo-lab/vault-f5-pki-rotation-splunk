variable "region" {
  description = "AWS region"
  type        = string
}

variable "owner" {
  description = "Resource owner identified using an email address"
  type        = string
}
variable "admin_username" {
  description = "ubuntu admin user"
  type        = string
  default = "ubuntu"
}

variable "ssh_pubkey" {
  description = "ssh public key"
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOL7uceFyeKxFV/uH7va5ZUhYaFOuoNxY9fUrJtMxRfUewJ0INuQPoGvqmu2oOJVo+jz5tLDJGDl49TifEIUczIDIrVIVnYgwCL3aIUsiJPGPrjfqEtiwJMVc6ebePdxMOKFccxqShE1lQNNeu0iZThSYjpxC8d30+ZaXNGrENNTijhWHows7gQE5TVv2Dqu63hHlaipuuFo03PQuiLiqvPaMeByQi8XztYk5na+dHUmNGkwqHYqLrBIJhZnVfmdXBNNEwoW7T2fUg9MSm3DHlRp2wvDK07zj+TW/03YRCFiPhEMidXpybbEa3FtiC1QW3E3hOobOKDNsYbZS9M06/Tjg0uNW3cOFOwz/aEzAi+ZFm0fUV7uU9hkD5zinvyBgimIVkTBZVTpdgENcPRgjyWJj0mi7jJ1cbnwC90BE7wJGg1EkSAQTKb2wG9qzI85VNBtUZ8cAg+wOWnl4SkK50ZQucWoBFFI46vI/rQLfLU9rDMINN0FMxcI84q0+SxHc= simon.lynch@simon.lynch-TLYHK3HJGJ"
}
variable "prefix" {
  description = "resource prefix"
  type        = string
  default = "demo"
}
variable "ttl" {
  description = "Resource TTL (time-to-live)"
  type        = number
}

variable "deployment_id" {
  description = "Deployment id"
  type        = string
}


variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(any)
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(any)
}

variable "eks_cluster_version" {
  description = "EKS cluster version"
  type        = string
}

variable "eks_cluster_service_cidr" {
  description = "EKS cluster service cidr"
  type        = string
}

variable "eks_worker_instance_type" {
  description = "EKS worker nodes instance type"
  type        = string
}

variable "eks_worker_desired_capacity" {
  description = "EKS worker nodes desired capacity"
  type        = number
}

variable "hcp_hvn_provider_account_id" {
  description = "HCP HVN provider account id"
  type        = string
}

variable "hcp_hvn_cidr" {
  description = "HCP HVN cidr"
  type        = string
}