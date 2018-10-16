#shuffling the subnet
module "instance_profile" {
  source       = "github.com/traveloka/terraform-aws-iam-role//modules/instance?ref=v0.6.0"
  service_name = "${var.service_name}"
  cluster_role = "${local.role}"
}

resource "aws_iam_role_policy" "inline" {
  role   = "${module.instance_profile.role_name}"
  policy = "${data.aws_iam_policy_document.session_manager_policy.json}"
  name   = "inline"
}

resource "random_shuffle" "subnet" {
  input   = ["${data.aws_subnet_ids.subnet.ids}"]
  count   = "1"
  keepers = {}
}

resource "aws_instance" "this" {
  ami                    = "${data.aws_ami.bastion_ami.image_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${var.sg_ids}"]
  ebs_optimized          = "${var.ebs_optimized}"
  subnet_id              = "${element(random_shuffle.subnet.result,0)}"
  iam_instance_profile   = "${module.instance_profile.instance_profile_name}"

  root_block_device = {
    volume_size = "${var.root_volume_size}"
    volume_type = "gp2"
  }

  tags = {
    Name          = "${var.service_name}-${local.role}-01"
    ProductDomain = "${var.product_domain}"
    Cluster       = "${var.service_name}-${local.role}"
    Application   = "${local.role}"
    Environment   = "${var.environment}"
    Description   = "Bastion host for ${var.product_domain} product domain."
  }
}
