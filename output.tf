output "asg_bastion_name" {
  description = "The name of the auto scaling group for bastion"
  value       = "${module.aws-autoscaling_bastion_asg.asg_name}"
}

output "sg_bastion_name" {
  description = "The name of the security group for bastion instance"
  value       = "${aws_security_group.bastion.name}"
}

output "sg_postgres_name" {
  description = "The name of the security group for bastion postgres"
  value       = "${aws_security_group.postgres.name}"
}

output "sg_mongod_name" {
  description = "The name of the security group for bastion mongod"
  value       = "${aws_security_group.mongod.name}"
}

output "sg_mysql_name" {
  value = "${aws_security_group.mysql.name}"
}

output "instance_role_name" {
  description = "role name for the instances."
  value       = "${module.instance_profile.role_name}"
}
