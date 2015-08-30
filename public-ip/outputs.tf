output "address" {
  value = "${template_file.vars.address}"
}
output "cidr_block" {
  value = "${template_file.vars.address}/32"
}
