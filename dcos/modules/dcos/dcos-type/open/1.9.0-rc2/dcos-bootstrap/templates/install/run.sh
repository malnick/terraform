#!/bin/sh

curl -O ${var.dcos_download_path}
sudo mkdir genconf
echo -e '''bootstrap_url: http://${aws_instance.bootstrap.private_ip}:80\ncluster_name: ${data.template_file.cluster-name.rendered}\nexhibitor_storage_backend: static\nmaster_discovery: static\nmaster_list:\n - ${join(\n -  aws_instance.master.*.private_ip)}\nresolvers:\n - ${join(\n -  var.dcos_resolvers)}\nsecurity: ${var.dcos_security}\noauth_enabled: ${var.dcos_oauth_enabled}''' | sudo tee -a genconf/config.yaml
sudo cp /tmp/ip-detect genconf/.
sudo bash dcos_generate_config.*
sudo docker rm -f $(docker ps -a -q -f ancestor=nginx)
sudo docker run -d -p 80:80 -v $PWD/genconf/serve:/usr/share/nginx/html:ro nginx
