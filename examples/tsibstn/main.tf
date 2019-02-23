locals {
  vpc_id                     = "vpc-13ec9077"
  ami_owner_account_id       = "460124681500"
  session_manager_bucket_arn = "arn:aws:s3:::bucket-to-store-session-manager-logs"
  environment                = "staging"
  product_domain             = "tsi"
  service_name               = "tsibstn"
  asg_initial_capacity       = "1"
}

module "this" {
  source                        = "../../../terraform-aws-tvlk-bastion"
  service_name                  = "${local.service_name}"
  environment                   = "${local.environment}"
  product_domain                = "${local.product_domain}"
  vpc_id                        = "${local.vpc_id}"
  subnet_tier                   = "app"                                 #valid value only app, public, data
  ami_owner_account_id          = "${local.ami_owner_account_id}"
  session_manager_bucket_arn    = "${local.session_manager_bucket_arn}"
  asg_initial_capacity          = "${local.asg_initial_capacity}"
  description                   = "bastion for ${local.product_domain}"
  asg_wait_for_capacity_timeout = "10m"
}
