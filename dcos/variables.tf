variable "key_name" {
  description = "Key Name"
  default = "default"
}

variable "user" {
  description = "Username of the OS"
  default = "centos"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "aws_instance_type" {
  description = "AWS default instance type"
  default = "m3.xlarge"
}

variable "num_of_private_agents" {
  default = 3
}

variable "num_of_masters" {
  default = 5
}

variable "owner" {
  default = "mbernadin"
}

variable "expiration" {
  default = "1h"
}

variable "ip-detect" {
 type = "map"

 default = {
  aws = "scripts/cloud/aws/ip-detect.aws.sh"
 }
}

variable "os-init-script" {
 type = "map"

 default = {
 core = "scripts/os/coreos/coreos-init.aws.sh"
 centos = "scripts/os/centos/centos-init.aws.sh"
 }
}

variable "dcos_download_path" {
 default = "https://downloads.dcos.io/dcos/testing/master/dcos_generate_config.sh"
 description = "DC/OS version path"
}

# Core OS
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-b1cf19c6"
    us-east-1 = "ami-47096750"
    us-west-1 = "ami-3f75767a"
    us-west-2 = "ami-d2c924b2"
  }
}
