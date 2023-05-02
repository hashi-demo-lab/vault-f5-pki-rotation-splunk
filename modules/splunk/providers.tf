terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=4.21.0"
    }
    acme = {
        source = "vancluever/acme"
        version = "~> 2.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.3"
    }
    splunk = {
      source  = "splunk/splunk"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}
