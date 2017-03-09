# module

variable "bootstrap_private_ip" {}
variable "dcos_install_mode" {}

data "template_file" "agent-script" {
  template = "${file("templates/${var.state}/run.sh")}"

  vars {
    bootstrap_private_ip = "${var.bootstrap_private_ip}"
  }
}
