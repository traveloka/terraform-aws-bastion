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

data "aws_iam_policy_document" "session_manager_policy" {
  statement = {
    effect = "Allow"

    actions = [
      "ssm:DescribeAssociation",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:GetManifest",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
    ]

    resources = ["*"]
  }

  statement = {
    effect = "Allow"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]

    resources = ["*"]
  }

  statement = {
    effect = "Allow"

    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",
    ]

    resources = ["*"]
  }

  statement = {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstanceStatus",
    ]

    resources = ["*"]
  }

  statement = {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetEncryptionConfiguration",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [
      "${var.session_manager_bucket_arn}",
      "${var.session_manager_bucket_arn}/*",
    ]
  }
}

data "aws_subnet_ids" "app" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Tier = "app"
  }
}
