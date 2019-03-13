data "aws_subnet_ids" "subnet" {
  vpc_id = "${var.vpc_id}"

  filter = {
    name   = "tag:Tier"
    values = ["${var.subnet_tier}"]
  }
}

data "aws_ami" "bastion_ami" {
  most_recent = "true"
  owners      = ["${var.ami_owner_account_id}"]

  filter = {
    name   = "name"
    values = ["${var.ami_name_prefix}"]
  }
}

data "aws_subnet_ids" "app" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Tier = "app"
  }
}
