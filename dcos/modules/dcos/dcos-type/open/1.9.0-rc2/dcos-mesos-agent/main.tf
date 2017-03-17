# module

variable "bootstrap_private_ip" {}
variable "dcos_install_mode" {}

data "template_file" "agent-script" {
  template = "${file("${path.module}/templates/${var.dcos_install_mode}/run.sh")}"

  vars {
    bootstrap_private_ip = "${var.bootstrap_private_ip}"
  }
}

output "script" {
  value = "${data.template_file.agent-script}"
}
