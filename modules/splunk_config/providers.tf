terraform {
  required_providers {
    /*aws = {
      source  = "hashicorp/aws"
      version = "=4.54.0"
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
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.54.0"
    }*/
    splunk = {
      source  = "splunk/splunk"
    }/*
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }*/
  }
}