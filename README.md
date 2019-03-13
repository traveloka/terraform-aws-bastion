# terraform-aws-tvlk-bastion #
Terraform module to create ASG bastion host using ssm session manager on top of golden bastion AMI baked by site-infra team.
This module creates following resources:
* [aws_autoscaling_group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html).
To stop or start an instances, you can change the asg_capacity value.
* [aws_launch_config](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html).
* [aws_security_group](https://www.terraform.io/docs/providers/aws/r/security_group.html).
Several security group will be created by this module, to give access from this bastion, you need to attach the share security group to your database.

## Requirement ##
* An existing vpc.
* An existing subnet, recommended using private subnet.
* IAM Policy to grants access to use session manager and send logs to s3.

## Usage ##
To know more on how to use this module see [examples](examples/tsibstn)\.

## Terraform Version ##
This module was created using Terraform 0.11.6. So to be more safe, Terraform version 0.11.6 or newer is required to use this module.

## Authors ##
[Bernard Siaahan](https://github.com/siahaanbernard)\.

## License ##
Apache 2 Licensed. See [LICENSE](LICENSE)\. for full details.