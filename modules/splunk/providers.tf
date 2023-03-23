terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=4.21.0"
    }
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 2.20.0"
    }
    acme = {
        source = "vancluever/acme"
        version = "~> 2.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.3"
    }
  }
}