output "address" {
  value = "${template_file.ip.vars.address}"
}
output "cidr_block" {
  value = "${template_file.ip.vars.address}/32"
}
