output "asg_bastion_name" {
  description = "The name of the auto scaling group for bastion"
  value       = "${module.this.asg_bastion_name}"
}

output "sg_bastion_id" {
  description = "The name of the security group for bastion instance"
  value       = "${module.this.sg_bastion_id}"
}

output "sg_postgres_id" {
  description = "The name of the security group for bastion postgres"
  value       = "${module.this.sg_postgres_id}"
}

output "sg_mongod_id" {
  description = "The name of the security group for bastion mongod"
  value       = "${module.this.sg_mongod_id}"
}

output "sg_mysql_id" {
  description = "The name of the security group for bastion mysql"
  value       = "${module.this.sg_mysql_id}"
}
