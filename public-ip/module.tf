resource "template_file" "ip" {
  filename = "/dev/null"
  depends_on = "template_file.ip_runner"
  vars {
    address = "${file(var.ip_txt)}"
  }
}
resource "template_file" "ip_runner" {
  filename = "/dev/null"
  
  provisioner "local-exec" {
    command = "curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' > ${var.ip_txt}"
  }
}

variable "ip_txt" {
  default = "./ip.txt"
}
