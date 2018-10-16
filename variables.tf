variable "ebs_optimized" {
  description = "whether ec2 instance using ebs optimized or not"
  default     = "true"
  type        = "string"
}

variable "service_name" {
  description = "service name for the instance"
  type        = "string"
}

variable "vpc_id" {
  description = "vpc id where ec2 instances reside."
  type        = "string"
}

variable "subnet_tier" {
  description = "tier of subnet where ec2 instance reside."
  type        = "string"
  default     = "app"
}

variable "ami_owner_account_id" {
  description = "aws account id who owns the golden bastion AMI owner"
  type        = "string"
}

variable "product_domain" {
  description = "product domain who own this ec2 instances."
  type        = "string"
}

variable "instance_type" {
  description = "instance type for bastion hosts."
  default     = "m4.large"
  type        = "string"
}

variable "root_volume_size" {
  description = "size for root volume instances."
  default     = "8"
  type        = "string"
}

variable "environment" {
  description = "environment for this resources."
  type        = "string"
}

variable "sg_ids" {
  description = "list of security group ids for bastion host"
  type        = "list"
}

variable "session_manager_bucket_arn" {
  description = "arn of s3 bucket where the session manager input output stored"
  type        = "string"
}

variable "ami_name_prefix" {
  description = "prefix for ami filter"
  default     = "tvlk/ubuntu-14/tsi/bastion*"
  type        = "string"
}
