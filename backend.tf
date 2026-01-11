terraform {
  backend "s3" {
    bucket  = "terraform-state-974086408537-poc29-ap-south-1"
    key     = "project29/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

