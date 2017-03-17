# DCOS Module 

# Main Variables
variable "bootstrap_private_ip" {}
variable "dcos_install_mode" {}
variable "dcos-type" {}
variable "dcos_version" {}
variable "role" {}
variable "user" {}
# DCOS bootstrap node variables
variable "dcos_security" {}
variable "dcos_resolvers" {}
variable "dcos_oauth_enabled" {}
variable "dcos_master_discovery" {}
variable "dcos_aws_template_storage_bucket" {}
variable "dcos_aws_template_storage_bucket_path" {}
variable "dcos_aws_template_storage_region_name" {}
variable "dcos_aws_template_upload" {}
variable "dcos_aws_template_storage_access_key_id" {}
variable "dcos_aws_template_storage_secret_access_key" {}
variable "dcos_exhibitor_storage_backend" {}
variable "dcos_exhibitor_zk_hosts" {}
variable "dcos_exhibitor_zk_path" {}
variable "dcos_aws_access_key_id" {}
variable "dcos_aws_region" {}
variable "dcos_aws_secret_access_key" {}
variable "dcos_exhibitor_explicit_keys" {}
variable "dcos_s3_bucket" {}
variable "dcos_s3_prefix" {}
variable "dcos_exhibitor_azure_account_name" {}
variable "dcos_exhibitor_azure_account_key" {}
variable "dcos_exhibitor_azure_prefix" {}
variable "dcos_exhibitor_address" {}
variable "dcos_num_masters" {}
variable "dcos_customer_key" {}
variable "dcos_rexray_config_method" {}
variable "dcos_rexray_config_filename" {}
variable "dcos_auth_cookie_secure_flag" {}
variable "dcos_bouncer_expiration_auth_token_days" {}
variable "dcos_superuser_password_hash" {}
variable "dcos_cluster_name" {}
variable "dcos_superuser_username" {}
variable "dcos_telemetry_enabled" {}
variable "dcos_zk_super_credentials" {}
variable "dcos_zk_master_credentials" {}
variable "dcos_zk_agent_credentials" {}
variable "dcos_overlay_enable" {}
variable "dcos_overlay_config_attempts" {}
variable "dcos_overlay_mtu" {}
variable "dcos_overlay_network" {}
variable "dcos_vtep_subnet" {}
variable "dcos_vtep_mac_oui" {}
variable "dcos_overlays" {}
variable "dcos_dns_search" {}
variable "dcos_master_dns_bindall" {}
variable "dcos_use_proxy" {}
variable "dcos_http_proxy" {}
variable "dcos_https_proxy" {}
variable "dcos_no_proxy" {}
variable "dcos_check_time" {}
variable "dcos_docker_remove_delay" {}
variable "dcos_audit_logging" {}
variable "dcos_gc_delay" {}
variable "dcos_log_directory" {}
variable "dcos_process_timeout" {}
variable "dcos_cluster_docker_credentials" {}
variable "dcos_cluster_docker_credentials_dcos_owned" {}
variable "dcos_cluster_docker_credentials_write_to_etc" {}
variable "dcos_cluster_docker_credentials_enabled" {}

# Terraform Bug https://github.com/hashicorp/terraform/issues/9488 is what is stopping this functionality
# Dynamically Creates Config.yaml based on particular versions
# data "template_file" "script" {
#  template = "${file("${path.module}/dcos-type/${var.dcos-type}/${var.dcos-version}/${var.role}/templates/${var.dcos_install_mode}/run.sh")}"
#
#  vars {
#    # Master and Agent Var
#    bootstrap_private_ip = "${var.bootstrap_private_ip}"
#    
#    # Bootstrap Config Vars
#    custom_dcos_bootstrap_port = "${var.custom_dcos_bootstrap_port}"
#    custom_dcos_download_path = "${coalesce(var.custom_dcos_download_path, var.${dcos-type}_download_path[${dcos-version}])}"
#    dcos_agent_list = "${aws_instance.agent.*.private_ip}"
#    dcos_audit_logging = "${var.dcos_audit_logging}"
#    dcos_auth_cookie_secure_flag = "${var.dcos_auth_cookie_secure_flag}"
#    dcos_aws_access_key_id = "${var.dcos_aws_access_key_id}"
#    dcos_aws_region = "${var.dcos_aws_region}"
#    dcos_aws_secret_access_key = "${var.dcos_aws_secret_access_key}"
#    dcos_aws_template_storage_access_key_id = "${var.dcos_aws_template_storage_access_key_id}"
#    dcos_aws_template_storage_bucket = "${var.dcos_aws_template_storage_bucket}"
#    dcos_aws_template_storage_bucket_path = "${var.dcos_aws_template_storage_bucket_path}"
#    dcos_aws_template_storage_region_name = "${var.dcos_aws_template_storage_region_name}"
#    dcos_aws_template_storage_secret_access_key = "${var.dcos_aws_template_storage_secret_access_key}"
#    dcos_aws_template_upload = "${var.dcos_aws_template_upload}"
#    dcos_bouncer_expiration_auth_token_days = "${var.dcos_bouncer_expiration_auth_token_days}"
#    dcos_check_time = "${var.dcos_check_time}"
#    dcos_cluster_docker_credentials = "${var.dcos_cluster_docker_credentials}"
#    dcos_cluster_docker_credentials_dcos_owned = "${var.dcos_cluster_docker_credentials_dcos_owned}"
#    dcos_cluster_docker_credentials_enabled = "${var.dcos_cluster_docker_credentials_enabled}"
#    dcos_cluster_docker_credentials_write_to_etc = "${var.dcos_cluster_docker_credentials_write_to_etc}"
#    dcos_cluster_name  = "${coalesce(var.dcos_cluster_name, data.template_file.cluster-name.rendered)}"
#    dcos_customer_key = "${var.dcos_customer_key}"
#    dcos_dns_search = "${var.dcos_dns_search}"
#    dcos_docker_remove_delay = "${var.dcos_docker_remove_delay}"
#    dcos_exhibitor_address = "${var.dcos_exhibitor_address}"
#    dcos_exhibitor_azure_account_key = "${var.dcos_exhibitor_azure_account_key}"
#    dcos_exhibitor_azure_account_name = "${var.dcos_exhibitor_azure_account_name}"
#    dcos_exhibitor_azure_prefix = "${var.dcos_exhibitor_azure_prefix}"
#    dcos_exhibitor_explicit_keys = "${var.dcos_exhibitor_explicit_keys}"
#    dcos_exhibitor_storage_backend = "${var.dcos_exhibitor_storage_backend}"
#    dcos_exhibitor_zk_hosts = "${var.dcos_exhibitor_zk_hosts}"
#    dcos_exhibitor_zk_path = "${var.dcos_exhibitor_zk_path}"
#    dcos_gc_delay = "${var.dcos_gc_delay}"
#    dcos_http_proxy = "${var.dcos_http_proxy}"
#    dcos_https_proxy = "${var.dcos_https_proxy}"
#    dcos_log_directory = "${var.dcos_log_directory}"
#    dcos_master_discovery = "${var.dcos_master_discovery}"
#    dcos_master_dns_bindall = "${var.dcos_master_dns_bindall}"
#    dcos_master_list = "${aws_instance.master.*.private_ip}"
#    dcos_no_proxy = "${var.dcos_no_proxy}"
#    dcos_num_masters = "${var.dcos_num_masters}"
#    dcos_oauth_enabled = "${var.dcos_oauth_enabled}"
#    dcos_overlay_config_attempts = "${var.dcos_overlay_config_attempts}"
#    dcos_overlay_enable = "${var.dcos_overlay_enable}"
#    dcos_overlay_mtu = "${var.dcos_overlay_mtu}"
#    dcos_overlay_network = "${var.dcos_overlay_network}"
#    dcos_overlays = "${var.dcos_overlays}"
#    dcos_process_timeout = "${var.dcos_process_timeout}"
#    dcos_public_agent_list = "${aws_instance.public_agent.*.private_ip}"
#    dcos_resolvers  = "${var.dcos_resolvers}"
#    dcos_rexray_config_filename = "${var.dcos_rexray_config_filename}"
#    dcos_rexray_config_method = "${var.dcos_rexray_config_method}"
#    dcos_s3_bucket = "${var.dcos_s3_bucket}"
#    dcos_s3_prefix = "${var.dcos_s3_prefix}"
#    dcos_security  = "${var.dcos_security}"
#    dcos_superuser_password_hash = "${var.dcos_superuser_password_hash}"
#    dcos_superuser_username = "${var.dcos_superuser_username}"
#    dcos_telemetry_enabled = "${var.dcos_telemetry_enabled}"
#    dcos_use_proxy = "${var.dcos_use_proxy}"
#    dcos_vtep_mac_oui = "${var.dcos_vtep_mac_oui}"
#    dcos_vtep_subnet = "${var.dcos_vtep_subnet}"
#    dcos_zk_agent_credentials = "${var.dcos_zk_agent_credentials}"
#    dcos_zk_master_credentials = "${var.dcos_zk_master_credentials}"
#    dcos_zk_super_credentials = "${var.dcos_zk_super_credentials}"
#  }
#}

  # Workaround for the bug above

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = "${var.bootstrap_private_ip}"
    user = "${var.user}"
  }

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
  provisioner "remote-exec" {
    inline = <<SCRIPT
curl -O ${var.dcos_download_path}
sudo mkdir genconf
echo -e '''bootstrap_url: http://${aws_instance.bootstrap.private_ip}:80\ncluster_name: ${data.template_file.cluster-name.rendered}\nexhibitor_storage_backend: static\nmaster_discovery: static\nmaster_list:\n - ${join("\n -  aws_instance.master.*.private_ip)}\nresolvers:\n - ${join("\n -  var.dcos_resolvers)}\nsecurity: ${var.dcos_security}\noauth_enabled: ${var.dcos_oauth_enabled}''' | sudo tee -a genconf/config.yaml
sudo cp /tmp/ip-detect genconf/.
sudo bash dcos_generate_config.*
sudo docker rm -f $(docker ps -a -q -f ancestor=nginx)
sudo docker run -d -p 80:80 -v $PWD/genconf/serve:/usr/share/nginx/html:ro nginx"
SCRIPT
  }

# Workaround for bug 9488
# output "script" {
#   value = "${data.template_file.script.rendered}"
# }
