#!/bin/sh

# Install Master Node
mkdir /tmp/dcos && cd /tmp/dcos
/usr/bin/curl -O ${bootstrap.private_ip}/dcos_install.sh
sudo bash dcos_install.sh master
# Master Node End
