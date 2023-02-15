variable "region" {
  description = "AWS region"
  type        = string
}

variable "owner" {
  description = "Resource owner identified using an email address"
  type        = string
}

variable "ttl" {
  description = "Resource TTL (time-to-live)"
  type        = number
}

variable "deployment_id" {
  description = "Deployment id"
  type        = string
}

variable "key_pair_key_name" {
  description = "Key pair name"
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