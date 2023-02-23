variable "app_prefix" {
    type = string
    description = "prefix used for f5 resource create uniqueness"
    default = "demoapp"
}

variable "vip_ip" {
    type = string
    description = "Virtual Server IP"
    default = "10.200.10.50"
}


variable "node_list" {
    type = list(string)
    description = "list of node IP addresses"
    default = ["192.168.10.2"]
}

variable "f5_mgmtPublicDNS" {
    type = string
    description = "F5 management address"
    default = "ec2-13-54-152-67.ap-southeast-2.compute.amazonaws.com:8443"
    sensitive = true
}

variable "f5_username" {
    type = string
    description = "F5 management username"
    default = "bigipuser"
    sensitive = true
}

variable "f5_password" {
    type = string
    description = "F5 management password"
    sensitive = true
}

variable "f5_partition" {
    type = string
    description = "F5 partition"
    default = "Common"
}

variable "pki_intermediate_path" {
    type = string
    description = "pki intermediate path"
    default =  "pki_intermediate"
}

variable "pki_role" {
    type = string
    description = "pki role name"
    default =  "f5demo"
}

variable "common_name" {
    type = string
    description = "certificate common name"
    default = "prod.f5demo.com"
}
