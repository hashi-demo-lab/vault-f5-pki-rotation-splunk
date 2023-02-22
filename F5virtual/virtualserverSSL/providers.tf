terraform {
  required_providers {
    bigip = {
      source = "F5Networks/bigip"
      version = "1.16.2"
    }
  }
}

provider "bigip" {
  address = var.f5_mgmtPublicDNS
  username = var.f5_username
}

provider "vault" {
  namespace = "admin"
}