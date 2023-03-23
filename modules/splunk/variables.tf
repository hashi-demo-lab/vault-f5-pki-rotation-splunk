##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default = "user"
}

variable "email" {
  description = "your email address"
  default = "user@domain.com"
}

variable "splunk_domain" {
  description = "This is the url that will be created <value>.aws.hashidemos.io"
  default = "splunk.user"
}

variable "region" {
  description = "The region where the resources are created."
  default     = "ap-southeast-2"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}

variable "ttl" {
  description = "Specifies the AWS Time To Live before reaping."
  default     = "8"
}

variable "name" {
  description = "Specifies the internal HashiCorp owner."
  default     = "Armon Hashimoto"
}

