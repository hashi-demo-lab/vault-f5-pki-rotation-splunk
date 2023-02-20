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