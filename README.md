# aws-terraform-modules
A collection of general-purpose Terraform modules for AWS infrastructure

## vpc-2-zones
Defines the bare basics needed to do anything useful in AWS.
Upon module creation, you will have
* A VPC (your network)
* A pair of public subnets
* A pair of private subnets (all private addresses netmask 255.255.128.0)
* A network address translation (NAT) EC2 instance for letting private EC2 instances communicate outside of the VPC
* An SSH bastion host for creating SSH tunnels to your private IP addresses as needed
* A security group for running Packer builders

With two zones available, you will be able to deploy services which are resilient to availability zone failures.

### Example
```
module "vpc" {
  source = "github.com/joescii/aws-terraform-modules/vpc-2-zones"
  
  vpc_name = "lift-jetty-cluster"
  ec2_key_name = "my-key"
  region = "us-west-1"
  zone_A = "us-west-1b"
  zone_B = "us-west-1c"
  nat_ami = "ami-ada746e9"
  bastion_ami = "ami-896d93cd"
}

# Use the outputs in other resources...
resource "aws_security_group" "my_sg" {
  name = "my-sg"
	vpc_id = "${module.vpc.vpc_id}"
}
```

## us-west-1
Defines region-specific resources in `us-west-1`.
This module works well with `vpc-2-zones`.
Other regions could be made to mirror this one as needed.
Using this approach, you can have switch regions simply by changing the module `source`.

### Example
```
module "region" {
  source = "github.com/joescii/aws-terraform-modules/us-west-1"
}

# Use the outputs in other resources, even other modules...
module "vpc" {
  source = "github.com/joescii/aws-terraform-modules/vpc-2-zones"
  
  vpc_name = "my-vpc"
  ec2_key_name = "my-key"
  region = "${module.region.region}"
  zone_A = "${module.region.zone_A}"
  zone_B = "${module.region.zone_B}"
  nat_ami = "${module.region.nat_ami}"
  bastion_ami = "${module.region.bastion_ami}"
}
```

Note that variables cannot be used in the `source` attribute at this time (see [Terraform issue 2940](https://github.com/hashicorp/terraform/issues/2940)).

## mysql56_utf8
Defines a parameter group for making MySQL not be completely terrible.
In particular, it sets up the MySQL instance to use UTF-8.
Then you can connect to your DB with a URL with these parameters: `utf8mb4&collation=utf8mb4_general_ci`

### Example
```
module "mysql56_utf8" {
  source = "github.com/joescii/aws-terraform-modules/mysql56_utf8"
}

# Use the output name to build an instance...
resource "aws_db_instance" "my_db" {
  identifier = "my-db"
  engine = "mysql"
  engine_version = "5.6.19a"
  parameter_group_name = "${module.mysql56_utf8.name}"

  # ...
}
```

## public-ip
Defines a module that is an awesome idea but sadly doesn't work at the moment (see [Terraform issue 3125](https://github.com/hashicorp/terraform/issues/3125)).
On a Unix system equipped with `curl`, `sed`, and `tr` on the `PATH`, this module will determine the public IP address of the system running Terraform.
This module outputs both `address` and `cidr_block` for use in defining security groups only accessible from this machine.
Hence you could create a security group for packer which will only allow your CI server to connect.

Assuming the aforementioned issue is one day resolved, there is another quirk that can be worked around.
You'll have to touch `./ip.txt` in the current directory before invoking `terraform apply`.
It seems that terraform checks the existence of the text file long before it is written.

### Example
```
module "public_ip" {
  source = "github.com/joescii/aws-terraform-modules/public-ip"
}

# Use it in your vpc module...
module "vpc" {
  source = "github.com/joescii/aws-terraform-modules/vpc-2-zones"
  
  # To only open up the packer security group to this currently running server
  packer_sg_cidr_block = "${module.public_ip.cidr_block}"
  vpc_name = "lift-jetty-cluster"
  ec2_key_name = "${var.ec2_key_name}"
  region = "${module.region.region}"
  zone_A = "${module.region.zone_A}"
  zone_B = "${module.region.zone_B}"
  nat_ami = "${module.region.nat_ami}"
  bastion_ami = "${module.region.bastion_ami}"
}
```
