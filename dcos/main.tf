# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags {
   Name = "${var.owner}-vpc"
  } 
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch public nodes into
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.0.0/22"
  map_public_ip_on_launch = true
}

# Create a subnet to launch slave private node into
resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.4.0/22"
  map_public_ip_on_launch = true
}

# A security group that allows all port access to internal vpc
resource "aws_security_group" "any_access_internal" {
  name        = "cluster-security-group"
  description = "Manage all ports cluster level"
  vpc_id      = "${aws_vpc.default.id}"

 # full access internally 
 ingress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${aws_vpc.default.cidr_block}"]
  }
  
 # full access internally
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${aws_vpc.default.cidr_block}"]
  }
}

# A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name        = "elb-security-group"
  description = "A security group for the elb"
  vpc_id      = "${aws_vpc.default.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# A security group for Admins to control access
resource "aws_security_group" "admin" {
  name        = "admin-security-group"
  description = "Administrators can manage their machines"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# A security group for the ELB so it is accessible via the web 
# with some master ports for internal access only
resource "aws_security_group" "master" {
  name        = "master-security-group"
  description = "Security group for masters"
  vpc_id      = "${aws_vpc.default.id}"

 # Mesos Master access from within the vpc
 ingress {
   to_port = 5050
   from_port = 5050
   protocol = "tcp"
   cidr_blocks = ["${aws_vpc.default.cidr_block}"]
 }

 # Adminrouter access from within the vpc
 ingress {
   to_port = 80
   from_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 # Adminrouter SSL access from anywhere
 ingress {
   to_port = 443
   from_port = 443
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 # Marathon access from within the vpc
 ingress {
   to_port = 8080
   from_port = 8080
   protocol = "tcp"
   cidr_blocks = ["${aws_vpc.default.cidr_block}"]
 }
 
 # Exhibitor access from within the vpc
 ingress {
   to_port = 8181
   from_port = 8181
   protocol = "tcp"
   cidr_blocks = ["${aws_vpc.default.cidr_block}"]
 }

 # Zookeeper Access from within the vpc
 ingress {
   to_port = 2181
   from_port = 2181
   protocol = "tcp"
   cidr_blocks = ["${aws_vpc.default.cidr_block}"]
 }

 # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# A security group for public slave so it is accessible via the web
resource "aws_security_group" "public_slave" {
  name        = "public-slave-security-group"
  description = "security group for slave public"
  vpc_id      = "${aws_vpc.default.id}"
 
  # Allow ports within range
  ingress {
    to_port = 21
    from_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow ports within range
  ingress {
    to_port = 5050
    from_port = 23
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  # Allow ports within range
  ingress {
    to_port = 32000
    from_port = 5052
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  # Allow ports within range
  ingress {
    to_port = 21
    from_port = 0
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  # Allow ports within range
  ingress {
    to_port = 5050
    from_port = 23
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  # Allow ports within range
  ingress {
    to_port = 32000
    from_port = 5052
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# A security group for private slave so it is accessible internally
resource "aws_security_group" "private_slave" {
  name        = "private-slave-security-group"
  description = "security group for slave private"
  vpc_id      = "${aws_vpc.default.id}"

  # full access internally
  ingress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["${aws_vpc.default.cidr_block}"]
   }
 
  # full access internally
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["${aws_vpc.default.cidr_block}"]
   }
}

# Internal Load Balancer Access
# Mesos Master, Zookeeper, Exhibitor, Adminrouter, Marathon
resource "aws_elb" "internal-master-elb" {
  name = "${var.owner}-int-master-elb"

  subnets         = ["${aws_subnet.public.id}"]
  security_groups = ["${aws_security_group.master.id}"]
  instances       = ["${element(aws_instance.master.*.id, count.index)}"]

  listener {
    lb_port	      = 5050
    instance_port     = 5050
    lb_protocol       = "HTTP"
    instance_protocol = "HTTP"
  }

  listener {
    lb_port           = 2181
    instance_port     = 2181
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }

  listener {
    lb_port           = 8181
    instance_port     = 8181
    lb_protocol       = "HTTP"
    instance_protocol = "HTTP"
  }
  
  listener {
    lb_port           = 80
    instance_port     = 80
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }
  
  listener {
    lb_port           = 443
    instance_port     = 443
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }

  listener {
    lb_port           = 8080
    instance_port     = 8080
    lb_protocol       = "HTTP"
    instance_protocol = "HTTP"
  }
}

# Public Master Load Balancer Access
# Adminrouter Only
resource "aws_elb" "public-master-elb" {
  name = "${var.owner}-dcos-public-master-elb"

  subnets         = ["${aws_subnet.public.id}"]
  security_groups = ["${aws_security_group.public_slave.id}"]
  instances       = ["${element(aws_instance.master.*.id, count.index)}"]

  listener {
    lb_port           = 80
    instance_port     = 80
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }

  listener {
    lb_port           = 443
    instance_port     = 443
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "TCP:5050"
    interval = 30
  }
}

# Public Agent Load Balancer Access
# Adminrouter Only
resource "aws_elb" "public-agent-elb" {
  name = "${var.owner}-dcos-public-agent-elb"

  subnets         = ["${aws_subnet.public.id}"]
  security_groups = ["${aws_security_group.public_slave.id}"]
  instances       = ["${element(aws_instance.agent.*.id, count.index)}"]

  listener {
    lb_port           = 80
    instance_port     = 80
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }

  listener {
    lb_port           = 443
    instance_port     = 443
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 2
    target = "HTTP:9090/_haproxy_health_check"
    interval = 5
  }
}

resource "aws_instance" "master" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.user}"

    # The connection will use the local SSH agent for authentication.
  }

  count = "${var.num_of_masters}"
  instance_type = "${var.aws_instance_type}"

  tags {
   owner = "${var.owner}"
   expiration = "${var.expiration}"
   Name = "${var.owner}-master-${count.index + 1}"
  }

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "default"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.master.id}","${aws_security_group.admin.id}","${aws_security_group.any_access_internal.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.public.id}"

  # OS init script
  provisioner "file" {
   source = "${var.os-init-script["coreos"]}"
   destination = "/tmp/coreos-provision.sh"
   }

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
    provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/coreos-provision.sh",
      "sudo bash /tmp/coreos-provision.sh",
    ]
  }
}

resource "aws_instance" "agent" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.user}"

    # The connection will use the local SSH agent for authentication.
  }

  count = "${var.num_of_private_agents}"
  instance_type = "${var.aws_instance_type}"

  tags {
   owner = "${var.owner}"
   expiration = "${var.expiration}"
   Name =  "${var.owner}-agent-${count.index + 1}"
  }
  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "default"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.private_slave.id}","${aws_security_group.admin.id}","${aws_security_group.any_access_internal.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.private.id}"

  # OS init script
  provisioner "file" {
   source = "${var.os-init-script["coreos"]}"
   destination = "/tmp/coreos-provision.sh"
   }
 
 # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
    provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/coreos-provision.sh",
      "sudo bash /tmp/coreos-provision.sh",
    ]
  }
}

resource "aws_instance" "bootstrap" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.user}"

    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "${var.aws_instance_type}"

  tags {
   owner = "${var.owner}"
   expiration = "${var.expiration}"
   Name = "${var.owner}-bootstrap"
  }

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "default"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.master.id}","${aws_security_group.admin.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.public.id}"

  # DCOS ip detect script
  provisioner "file" {
   source = "${var.ip-detect["aws"]}"
   destination = "/tmp/ip-detect"
   }

  # OS init script
  provisioner "file" {
   source = "${var.os-init-script["coreos"]}"
   destination = "/tmp/coreos-provision.sh"
   }

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
    provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/coreos-provision.sh",
      "sudo bash /tmp/coreos-provision.sh", 
    ]
  }
}

resource "null_resource" "bootstrap" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", aws_instance.bootstrap.*.id)}"
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = "${element(aws_instance.bootstrap.*.public_ip, 0)}"
    user = "${var.user}"
  }

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
  provisioner "remote-exec" {
    inline = [
      "curl -O ${var.dcos_download_path}",
      "sudo mkdir genconf",
      "echo -e '''bootstrap_url: http://${aws_instance.bootstrap.private_ip}:80\ncluster_name: ${var.owner}\nexhibitor_storage_backend: static\nmaster_discovery: static\nmaster_list:\n - ${join("\n - ", aws_instance.master.*.private_ip)}\nresolvers: \n - 8.8.8.8\n - 8.8.4.4''' | sudo tee -a genconf/config.yaml",
      "sudo cp /tmp/ip-detect genconf/.",
      "sudo bash dcos_generate_config.*",
      "sudo docker run -d -p 80:80 -v $PWD/genconf/serve:/usr/share/nginx/html:ro nginx"
    ]
  }
}

resource "null_resource" "master" {
  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = "${element(aws_instance.master.*.public_ip, count.index)}"
    user = "${var.user}"
  }

  count = "${var.num_of_masters}"

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 
  provisioner "remote-exec" {
    inline = [
      "mkdir /tmp/dcos && cd /tmp/dcos",
      "until $(curl --output /dev/null --silent --head --fail http://${aws_instance.bootstrap.private_ip}/dcos_install.sh); do printf 'waiting for bootstrap node to serve...'; sleep 20; done",
      "/usr/bin/curl -O ${aws_instance.bootstrap.private_ip}/dcos_install.sh",
      "sudo bash dcos_install.sh master",
      "until $(curl --output /dev/null --silent --head --fail http://${element(aws_instance.master.*.public_ip, count.index)}/); do printf 'loading DC/OS...'; sleep 10; done"
    ]
  }
}

resource "null_resource" "agent" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    cluster_instance_ids = "${join(",", aws_instance.agent.*.id)}"
  }

  count = "${var.num_of_private_agents}"

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = "${element(aws_instance.agent.*.public_ip, count.index)}"
    user = "${var.user}"
  }

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 
  provisioner "remote-exec" {
    inline = [
      "mkdir /tmp/dcos && cd /tmp/dcos",
      "until $(curl --output /dev/null --silent --head --fail http://${aws_instance.bootstrap.private_ip}/dcos_install.sh); do printf 'waiting for bootstrap node to serve...'; sleep 20; done",
      "/usr/bin/curl -O ${aws_instance.bootstrap.private_ip}/dcos_install.sh",
      "sudo bash dcos_install.sh slave"
    ]
  }
}
