variable "key_name" {
  description = "Key name assicated with your instances for login"
  default = "default"
}

variable "user" {
  description = "Username of the OS"
  default = "core"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}

variable "aws_instance_type" {
  description = "AWS default instance type"
  default = "m3.xlarge"
}

variable "num_of_private_agents" {
  description = "DC/OS Private Agents Count"
  default = 3
}

variable "num_of_masters" {
  description = "DC/OS Master Nodes Count (Odd only)"
  default = 3
}

variable "owner" {
  description = "Paired with Cloud Cluster Cleaner will notify on expiration via slack"
  default = "mbernadin"
}

variable "expiration" {
  description = "Paired with Cloud Cluster Cleaner will notify on expiration via slack"
  default = "1h"
}

variable "ip-detect" {
 description = "Used to determine the private IP address of instances"
 type = "map"

 default = {
  aws = "scripts/cloud/aws/ip-detect.aws.sh"
 }
}

variable "os-init-script" {
 description = "Init Scripts that runs post-AMI deployment and pre-DC/OS install" 
 type = "map"

 default = {
  coreos = "scripts/os/coreos/coreos-init.aws.sh"
 }
}

variable "instance_disk_size" {
 description = "Default size of the root disk (GB)"
 default = "128"
}

variable "dcos_download_path" {
 default = "https://downloads.dcos.io/dcos/testing/master/dcos_generate_config.sh"
 description = "DC/OS version path"
}

variable "dcos_security" {
 default = "permissive"
 description = "DC/OS EE security mode: either disabled, permissive, or strict."
}

variable "dcos_resolvers" {
 default = [ "8.8.8.8", "8.8.4.4" ]
 description = "DNS Resolver for external name resolution"
}

variable "dcos_oauth_enabled" {
 default = "true"
 description = "DC/OS Open Flag for Open Auth"
}

# Core OS
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-163e7e65"
    us-east-1 = "ami-21732036"
    us-west-1 = "ami-161a5176"
    us-west-2 = "ami-078d5367"
  }
}
