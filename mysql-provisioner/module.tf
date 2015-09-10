variable "bastion_user" {}
variable "bastion_host" {}
variable "src_file" {}
variable "dst_file" {}
variable "rds_host" {}
variable "rds_port" {}
variable "db_username" {}
variable "dp_password" {}

resource "null_resource" "mysq-provisioner" {
  provisioner "file" {
    source = "${var.src_file}"
    destination = "/tmp/${var.dst_file}"
  }
  
  provisioner "remote-exec" {
    connection {
      user = "${var.bastion_user}"
      host = "${var.bastion_host}"
    }

    inline = [
      "mysql -h ${var.rds_host} -P ${var.rds_port} --user=${var.db_username} --password=${var.db_password} < ${var.dst_file}",
      "rm ${var.dst_file}"
    ]
  }
}
