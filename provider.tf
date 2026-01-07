terraform {
required_providers {
aws {
    source = "hasicorp/aws"
    version = "~> 6.0"
    }
  }
}

provider "aws" {
  features {}
  region = "us-southeast-2"
}  
