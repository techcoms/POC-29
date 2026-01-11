provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source    = "./modules/ec2"
  subnet_id = module.vpc.public_subnet_id
  vpc_id    = module.vpc.vpc_id
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}
