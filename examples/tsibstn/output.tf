output "asg_bastion_name" {
  description = "The name of the auto scaling group for bastion"
  value       = "${module.this.asg_bastion_name}"
}

output "sg_bastion_id" {
  description = "id of the security group for bastion instance"
  value       = "${module.this.sg_bastion_id}"
}

output "shared_sg_postgres_id" {
  description = "id of shared security group for postgres."
  value       = "${module.this.shared_sg_postgres_id}"
}

output "shared_sg_mongod_id" {
  description = "id of shared security group for mongod."
  value       = "${module.this.shared_sg_mongod_id}"
}

output "shared_sg_mysql_id" {
  description = "id of shared security group for mysql."
  value       = "${module.this.shared_sg_mysql_id}"
}

output "shared_sg_memcached_id" {
  description = "id of shared security group for memcached."
  value       = "${module.this.shared_sg_memcached_id}"
}

output "shared_sg_redis_id" {
  description = "id of shared security group for redis."
  value       = "${module.this.shared_sg_redis_id}"
}

output "instance_role_name" {
  description = "role name for the instances."
  value       = "${module.this.instance_role_name}"
}
