## v4.0.0 (Apr 21, 2021)
ENHANCEMENTS:

* Update autoscaling group to use launch template instead of launch config

FEATURES:

* Add support for root volume type value to gp3

## v3.0.1 (Apr 19, 2021)
ENHANCEMENTS:

* Update default to use Ubuntu 20 AMI

## v3.0.0 (Sep 30, 2020)
ENHANCEMENTS:

* Upgrade config to support terraform v0.12


## v2.1.3 (Aug 06, 2020)

NOTES:

* Add .pre-commit-config.yaml to include terraform_fmt and terraform_docs
* Update README.md to be informative

## v2.1.2 (Jan 29, 2020)

ENHANCEMENTS:

* feature: Allow egress on port 80 on bastion hosts so that they can install more tooling from apt-get

## v2.1.1 (Jan 23, 2020)
BUG FIXES:

* Fixes a bug where ingress security group rule for 3306 is mistakenly attached to postgres' security group instead of mysql's security group

## v2.1.0 (Sep 11, 2019)

FEATURES:

* Add support to manage DynamoDB Table

## v2.0.2 (May 7, 2019)

BUG FIXES:

* Use correct SG in redis egress and add ingress rules for memcached and Redis

## v2.0.1 (Mar 25, 2019)

ENHANCEMENTS:

* Used terraform autoscaling v0.1.5 (#4)

## v2.0.0 (Mar 14, 2019)

NOTES: 

* Create bastion using ASG

## v1.0.0 (Oct 16, 2018)

NOTES:

* Remove stage tag, since it is not shared with other account.
