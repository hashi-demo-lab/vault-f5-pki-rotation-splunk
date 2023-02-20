variable "app_prefix" {
    type = string
    description = "prefix used for f5 resource create uniqueness"
    default = "demoapp"
}


variable "node_list" {
    type = list(string)
    description = "prefix used for f5 resource create uniqueness"
    default = ["192.168.10.2"]
}

variable "f5_mgmtPublicDNS" {
    type = string
    description = "F5 management address"
    default = "ec2-54-153-133-171.ap-southeast-2.compute.amazonaws.com:8443"
    sensitive = true
}

variable "f5_username" {
    type = string
    description = "F5 management username"
    default = "bigipuser"
    sensitive = true
}

