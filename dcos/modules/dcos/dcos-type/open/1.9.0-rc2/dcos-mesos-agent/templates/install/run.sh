#!/bin/sh

# Install Mesos Agent
mkdir /tmp/dcos && cd /tmp/dcos
until $(curl --output /dev/null --silent --head --fail ${bootstrap_private_ip}/dcos_install.sh); do printf 'waiting for bootstrap node to serve...'; sleep 20; done
/usr/bin/curl -O ${bootstrap_private_ip}/dcos_install.sh
sudo bash dcos_install.sh slave
# Mesos Agent Install Complete
