output "asg_bastion_name" {
  description = "The name of the auto scaling group for bastion"
  value       = "${module.aws-autoscaling_bastion_asg.asg_name}"
}

output "sg_bastion_id" {
  description = "id of security group for bastion instance."
  value       = "${aws_security_group.bastion.id}"
}

output "shared_sg_postgres_id" {
  description = "id of shared security group for postgres."
  value       = "${aws_security_group.postgres.id}"
}

output "shared_sg_mongod_id" {
  description = "id of shared security group for mongod."
  value       = "${aws_security_group.mongod.id}"
}

output "shared_sg_mysql_id" {
  description = "id of shared security group for mysql."
  value       = "${aws_security_group.mysql.id}"
}

output "shared_sg_memcached_id" {
  description = "id of shared security group for memcached."
  value       = "${aws_security_group.memcached.id}"
}

output "shared_sg_redis_id" {
  description = "id of shared security group for redis."
  value       = "${aws_security_group.redis.id}"
}

output "instance_role_name" {
  description = "role name for the instances."
  value       = "${module.bastion.role_name}"
}
