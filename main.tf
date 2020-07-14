# ASG
module "aws-autoscaling_bastion_asg" {
  source = "github.com/traveloka/terraform-aws-autoscaling?ref=v0.1.5"

  product_domain = "${var.product_domain}"
  service_name   = "${var.service_name}"
  cluster_role   = "${local.role}"
  environment    = "${var.environment}"

  application  = "${local.application}"
  description  = "${var.description}"
  lc_user_data = "${var.lc_user_data}"

  lc_security_groups = [
    "${aws_security_group.bastion.id}",
  ]

  lc_instance_profile = "${module.bastion.instance_profile_arn}"
  lc_instance_type    = "${var.instance_type}"
  lc_ami_id           = "${data.aws_ami.bastion_ami.id}"
  lc_key_name         = ""
  lc_ebs_optimized    = "${var.ebs_optimized}"
  lc_monitoring       = "${var.enable_detailed_monitoring}"

  asg_vpc_zone_identifier       = "${data.aws_subnet_ids.app.ids}"
  asg_min_capacity              = "${var.asg_capacity}"
  asg_max_capacity              = "${var.asg_capacity}"
  asg_health_check_grace_period = "${var.asg_health_check_grace_period}"
  asg_default_cooldown          = "${var.asg_default_cooldown}"
  asg_health_check_type         = "${var.asg_health_check_type}"
  asg_wait_for_capacity_timeout = "${var.asg_wait_for_capacity_timeout}"
  asg_tags                      = "${var.asg_tags}"
}

# Instance Role
module "bastion" {
  source = "github.com/traveloka/terraform-aws-iam-role.git//modules/instance?ref=v1.0.2"

  service_name   = "${var.service_name}"
  cluster_role   = "${local.role}"
  product_domain = "${var.product_domain}"
  environment    = "${var.environment}"
}

resource "aws_iam_role_policy" "policy_dynamodb_access" {
  name   = "DynamoDBAccess"
  role   = "${module.bastion.role_name}"
  policy = "${data.aws_iam_policy_document.dynamodb_access.json}"
}

# Security Groups
resource "aws_security_group" "bastion" {
  name        = "${var.service_name}-${local.role}"
  vpc_id      = "${var.vpc_id}"
  description = "${var.service_name}-${local.role} security group"

  tags = {
    Name          = "${var.service_name}-${local.role}"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.service_name}-${local.role}"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group" "postgres" {
  name        = "${var.service_name}-postgres"
  vpc_id      = "${var.vpc_id}"
  description = "${var.service_name}-postgres security group"

  tags = {
    Name          = "${var.service_name}-postgres"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.service_name}-postgres"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group" "mongod" {
  name        = "${var.service_name}-mongod"
  vpc_id      = "${var.vpc_id}"
  description = "${var.service_name}-mongod security group"

  tags = {
    Name          = "${var.service_name}-mongod"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.service_name}-mongod"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group" "mysql" {
  name        = "${var.service_name}-mysql"
  vpc_id      = "${var.vpc_id}"
  description = "${var.service_name}-mysql security group"

  tags = {
    Name          = "${var.service_name}-mysql"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.service_name}-mysql"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group" "memcached" {
  name        = "${var.service_name}-memcached"
  vpc_id      = "${var.vpc_id}"
  description = "${var.service_name}-memcached security group"

  tags = {
    Name          = "${var.service_name}-memcached"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.service_name}-memcached"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group" "redis" {
  name        = "${var.service_name}-redis"
  vpc_id      = "${var.vpc_id}"
  description = "${var.service_name}-redis security group"

  tags = {
    Name          = "${var.service_name}-redis"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.service_name}-redis"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group" "elasticsearch" {
  name        = "${var.service_name}-elasticsearch"
  vpc_id      = "${var.vpc_id}"
  description = "${var.service_name}-elasticsearch security group"

  tags = {
    Name          = "${var.service_name}-elasticsearch"
    Service       = "${var.service_name}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for ${var.service_name}-elasticsearch"
    ManagedBy     = "terraform"
  }
}

# Security Group Rules
resource "aws_security_group_rule" "bastion_https_all" {
  type              = "egress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Egress from ${var.service_name}-${local.role} to all in 443"
}

resource "aws_security_group_rule" "bastion_http_all" {
  type              = "egress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Egress from ${var.service_name}-${local.role} to all in 80"
}

resource "aws_security_group_rule" "bastion_ssh_all" {
  type              = "egress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.bastion.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Egress from ${var.service_name}-${local.role} to all in 22"
}

resource "aws_security_group_rule" "egress_from_bastion_to_postgres_5432" {
  type                     = "egress"
  from_port                = "5432"
  to_port                  = "5432"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.bastion.id}"
  source_security_group_id = "${aws_security_group.postgres.id}"
  description              = "Egress from ${var.service_name}-${local.role} to ${var.service_name}-postgres in 5432"
}

resource "aws_security_group_rule" "egress_from_bastion_to_mongod_27017" {
  type                     = "egress"
  from_port                = "27017"
  to_port                  = "27017"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.bastion.id}"
  source_security_group_id = "${aws_security_group.mongod.id}"
  description              = "Egress from ${var.service_name}-${local.role} to ${var.service_name}-mongod in 27017"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_postgres_5432" {
  type                     = "ingress"
  from_port                = "5432"
  to_port                  = "5432"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.postgres.id}"
  source_security_group_id = "${aws_security_group.bastion.id}"
  description              = "Ingress from ${var.service_name}-${local.role} to ${var.service_name}-postgres in 5432"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_mongod_27017" {
  type                     = "ingress"
  from_port                = "27017"
  to_port                  = "27017"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.mongod.id}"
  source_security_group_id = "${aws_security_group.bastion.id}"
  description              = "Ingress from ${var.service_name}-${local.role} to ${var.service_name}-mongod in 27017"
}

resource "aws_security_group_rule" "egress_from_bastion_to_mysql_3306" {
  type                     = "egress"
  from_port                = "3306"
  to_port                  = "3306"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.bastion.id}"
  source_security_group_id = "${aws_security_group.mysql.id}"
  description              = "Egress from ${var.service_name}-${local.role} to ${var.service_name}-mysql in 3306"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_mysql_3306" {
  type                     = "ingress"
  from_port                = "3306"
  to_port                  = "3306"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.mysql.id}"
  source_security_group_id = "${aws_security_group.bastion.id}"
  description              = "Ingress from ${var.service_name}-${local.role} to ${var.service_name}-mysql in 3306"
}

resource "aws_security_group_rule" "egress_from_bastion_to_memcached_11211" {
  type                     = "egress"
  from_port                = "11211"
  to_port                  = "11211"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.bastion.id}"
  source_security_group_id = "${aws_security_group.memcached.id}"
  description              = "Egress from ${var.service_name}-${local.role} to ${var.service_name}-memcached in 11211"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_memcached_11211" {
  type                     = "ingress"
  from_port                = "11211"
  to_port                  = "11211"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.memcached.id}"
  source_security_group_id = "${aws_security_group.bastion.id}"
  description              = "Ingress from ${var.service_name}-${local.role} to ${var.service_name}-memcached in 11211"
}

resource "aws_security_group_rule" "egress_from_bastion_to_redis_6379" {
  type                     = "egress"
  from_port                = "6379"
  to_port                  = "6379"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.bastion.id}"
  source_security_group_id = "${aws_security_group.redis.id}"
  description              = "Egress from ${var.service_name}-${local.role} to ${var.service_name}-redis in 6379"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_redis_6379" {
  type                     = "ingress"
  from_port                = "6379"
  to_port                  = "6379"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.redis.id}"
  source_security_group_id = "${aws_security_group.bastion.id}"
  description              = "Ingress from ${var.service_name}-${local.role} to ${var.service_name}-redis in 6379"
}

resource "aws_security_group_rule" "egress_from_bastion_to_elasticsearch_443" {
  type                     = "egress"
  from_port                = "443"
  to_port                  = "443"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.bastion.id}"
  source_security_group_id = "${aws_security_group.elasticsearch.id}"
  description              = "Egress from ${var.service_name}-${local.role} to ${var.service_name}-elasticsearch in 443"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_elasticsearch_443" {
  type                     = "ingress"
  from_port                = "443"
  to_port                  = "443"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elasticsearch.id}"
  source_security_group_id = "${aws_security_group.bastion.id}"
  description              = "Ingress from ${var.service_name}-${local.role} to ${var.service_name}-elasticsearch in 443"
}
