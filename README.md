# terraform-aws-tvlk-bastion

[![Release](https://img.shields.io/github/release/traveloka/terraform-aws-tvlk-bastion.svg)](https://github.com/traveloka/terraform-aws-tvlk-bastion/releases)
[![Last Commit](https://img.shields.io/github/last-commit/traveloka/terraform-aws-tvlk-bastion.svg)](https://github.com/traveloka/terraform-aws-tvlk-bastion/commits/master)
![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.png?v=103)

## Description

Terraform module to create ASG bastion host using ssm session manager on top of golden bastion AMI baked by site-infra team.
This module creates following resources:
* [aws_autoscaling_group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html).
To stop or start an instances, you can change the asg_capacity value.
* [aws_launch_config](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html).
* [aws_security_group](https://www.terraform.io/docs/providers/aws/r/security_group.html).
Several security group will be created by this module, to give access from this bastion, you need to attach the share security group to your database.

## Prerequisites
* An existing vpc.
* An existing subnet, recommended using private subnet.
* IAM Policy to grants access to use session manager and send logs to s3.

## Dependencies

This Terraform module uses another Terraform module, here is the list of Terraform module dependencies:

* [traveloka/terraform-aws-autoscaling](https://github.com/traveloka/terraform-aws-autoscaling)
* [traveloka/terraform-aws-iam-role](https://github.com/traveloka/terraform-aws-iam-role)


## Terraform Versions

Created and tested using Terraform version `0.11.14`

## Getting Started

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_asg\_tags | The created ASG (and spawned instances) will have these tags, merged over the default | `list` | `[]` | no |
| ami\_name\_prefix | prefix for ami filter | `string` | `"tvlk/ubuntu-14/tsi/bastion*"` | no |
| ami\_owner\_account\_id | aws account id who owns the golden bastion AMI owner. | `string` | n/a | yes |
| asg\_capacity | capacity of ec2 instances for autoscaling group | `string` | n/a | yes |
| asg\_default\_cooldown | Time, in seconds, the minimum interval of two scaling activities | `string` | `"300"` | no |
| asg\_health\_check\_grace\_period | Time, in seconds, to wait for new instances before checking their health | `string` | `"300"` | no |
| asg\_health\_check\_type | healthchek type for autoscaling group | `string` | `"EC2"` | no |
| asg\_wait\_for\_capacity\_timeout | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out | `string` | `"0m"` | no |
| description | description for this cluster | `string` | n/a | yes |
| ebs\_optimized | whether ec2 instance using ebs optimized or not | `string` | `"false"` | no |
| enable\_detailed\_monitoring | wheter to enable detailed monitoring for ec2 instances or not | `string` | `"false"` | no |
| environment | environment for this resources. | `string` | n/a | yes |
| instance\_type | instance type for bastion hosts. | `string` | `"t2.medium"` | no |
| lc\_user\_data | The spawned instances will have this user data. Use the rendered value of a terraform's `template_cloudinit_config` data | `string` | `" "` | no |
| product\_domain | product domain who own this ec2 instances. | `string` | n/a | yes |
| root\_volume\_size | size for root volume instances. | `string` | `"8"` | no |
| service\_name | service name for the instance | `string` | n/a | yes |
| subnet\_tier | tier of subnet where bastion ec2 instance reside, we recommend to use the subnet with tier app, as it is private. | `string` | `"app"` | no |
| vpc\_id | vpc id where ec2 instances reside. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| asg\_bastion\_name | The name of the auto scaling group for bastion |
| instance\_role\_name | role name for the instances. |
| sg\_bastion\_id | id of security group for bastion instance. |
| shared\_sg\_elasticsearch\_id | id of shared security group for elasticsearch. |
| shared\_sg\_memcached\_id | id of shared security group for memcached. |
| shared\_sg\_mongod\_id | id of shared security group for mongod. |
| shared\_sg\_mysql\_id | id of shared security group for mysql. |
| shared\_sg\_postgres\_id | id of shared security group for postgres. |
| shared\_sg\_redis\_id | id of shared security group for redis. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

This module accepting or open for any contributions from anyone, please see the [CONTRIBUTING.md](https://github.com/traveloka/terraform-aws-private-route53-zone/blob/master/CONTRIBUTING.md) for more detail about how to contribute to this module.

## License

This module is under Apache License 2.0 - see the [LICENSE](https://github.com/traveloka/terraform-aws-private-route53-zone/blob/master/LICENSE) file for details.