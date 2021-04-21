provider "aws" {
  region = "ap-southeast-1"
}

locals {
  vpc_id               = "vpc-012b395e72282f945"
  ami_owner_account_id = "745412875337"
  environment          = "staging"
  product_domain       = "tsi"
  service_name         = "tsibstn"
  asg_capacity         = "1"
}

module "this" {
  source               = "../../"
  service_name         = local.service_name
  environment          = local.environment
  product_domain       = local.product_domain
  vpc_id               = local.vpc_id
  ami_owner_account_id = local.ami_owner_account_id
  asg_capacity         = local.asg_capacity
  description          = "bastion for ${local.product_domain}"
  subnet_tier          = "public"
}
