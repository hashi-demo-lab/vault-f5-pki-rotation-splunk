terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.12.0"
    }

  }
}

provider "aws" {
  region = var.aws_region
}

provider "hcp" {

}


