variable "vpc_name" {}
variable "ec2_key_name" {}

# Region-dependent variables
variable "region" {}
variable "zone_A" {}
variable "zone_B" {}
variable "nat_ami" {}
variable "bastion_ami" {}
variable "packer_sg_cidr_block" {
  default = "0.0.0.0/0"
}
