output "vpc_id" {
  value = "${aws_vpc.default.id}"
}
output "zone_A_private_id" {
  value = "${aws_subnet.private-A.id}"
}
output "zone_A_private_cidr_block" {
  value = "${aws_subnet.private-A.cidr_block}"
}
output "zone_B_private_id" {
  value = "${aws_subnet.private-B.id}"
}
output "zone_B_private_cidr_block" {
  value = "${aws_subnet.private-B.cidr_block}"
}
output "zone_A_public_id" {
  value = "${aws_subnet.public-A.id}"
}
output "zone_A_public_cidr_block" {
  value = "${aws_subnet.public-A.cidr_block}"
}
output "zone_B_public_id" {
  value = "${aws_subnet.public-B.id}"
}
output "zone_B_public_cidr_block" {
  value = "${aws_subnet.public-B.cidr_block}"
}
output "packer_sg_id" {
  value = "${aws_security_group.packer.id}"
}
output "bastion_accessible_sg_id" {
  value = "${aws_security_group.bastion_accessible.id}"
}