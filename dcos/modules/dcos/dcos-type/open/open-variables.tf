variable "open_download_path" {
  type = "map"

  default = {
   "1.7-open"   = "https://downloads.dcos.io/dcos/testing/1.7-open/dcos_generate_config.sh"
   "1.8.0"      = "https://downloads.dcos.io/dcos/testing/1.8/dcos_generate_config.sh"
   "1.8.1"      = "https://downloads.dcos.io/dcos/testing/1.8.1/dcos_generate_config.sh"
   "1.8.2"      = "https://downloads.dcos.io/dcos/testing/1.8.2/dcos_generate_config.sh"
   "1.8.3"      = "https://downloads.dcos.io/dcos/testing/1.8.3/dcos_generate_config.sh"
   "1.8.4"      = "https://downloads.dcos.io/dcos/testing/1.8.4/dcos_generate_config.sh"
   "1.8.5"      = "https://downloads.dcos.io/dcos/testing/1.8.5/dcos_generate_config.sh"
   "1.8.6"      = "https://downloads.dcos.io/dcos/testing/1.8.6/dcos_generate_config.sh"
   "1.8.8"      = "https://downloads.dcos.io/dcos/testing/1.8.7/dcos_generate_config.sh"
   "1.8.9"      = "https://downloads.dcos.io/dcos/testing/1.8.8/dcos_generate_config.sh"
   "1.9.0-rc1"  = "https://downloads.dcos.io/dcos/testing/1.9.0-rc1/dcos_generate_config.sh"
   "1.9.0-rc2"  = "https://downloads.dcos.io/dcos/testing/1.9.0-rc2/dcos_generate_config.sh"
   "master"     = "https://downloads.dcos.io/dcos/testing/master/dcos_generate_config.sh"
  }
}
