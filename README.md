# terraform-aws-tvlk-bastion #
Terraform module to create ASG bastion host using ssm session manager on top of golden bastion AMI baked by site-infra team.

## Requirement ##
* An existing vpc.
* An existing subnet, recommended using private subnet.
* S3 bucket to store session managers log

## Usage ##
To know more on how to use this module see [examples](examples)\.

## Terraform Version ##
This module was created using Terraform 0.11.6. So to be more safe, Terraform version 0.11.6 or newer is required to use this module.

## Authors ##
[Bernard Siaahan](https://github.com/siahaanbernard)\.

## License ##
Apache 2 Licensed. See [LICENSE](LICENSE)\. for full details.