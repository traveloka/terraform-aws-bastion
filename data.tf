data "aws_region" "current" {}

data "aws_caller_identity" "aws_account" {}

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

data "aws_iam_policy_document" "dynamodb_access" {
  statement {
    sid = "AllowDynamoDBAccess"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource",
    ]

    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.aws_account.account_id}:table/${var.product_domain}*",
    ]
  }
}
