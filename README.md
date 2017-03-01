# Deploy DC/OS using Terraform

The purpose of this tool is to help deploy DC/OS EE and Open easily with different operating systems on different platforms. 

## Install Terraform

If you're on a mac environment with homebrew installed, run this command.

```bash
brew install terraform
```

If you want to leverage the terraform installer, feel free to check out https://www.terraform.io/downloads.html.

## Configure your Cloud Provider Credentials

### AWS

You can use an AWS credentials file to specify your credentials. The default location is `$HOME/.aws/credentials` on Linux and OS X, or `"%USERPROFILE%\.aws\credentials"` for Windows users.

### GCP and Azure

Coming Soon!


## Pull down the DC/OS terraform scripts below

```bash
terraform init github.com/bernadinm/terraform/dcos
```

## Deploy Terraform

You can deploy DC/OS with the current defaults which is 3 Masters and 3 private agents via this command running CoreOS

```bash
terraform apply
```

If you want to change the defaults, you can run this instead to deploy 1 master and 5 private agents:

```bash
terraform apply -var 'num_of_masters=1' -var 'num_of_private_agents=5'
```

## Destroy Terraform

```bash
terraform destroy
```

# DC/OS Versions

## DC/OS Stable (1.8.8)
```bash
terraform apply -var 'dcos_download_path=https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh'
```

## DC/OS EA (1.9)
```bash
terraform apply -var 'dcos_download_path=https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh'
```

## DC/OS Master (Default)
```bash
terraform apply
```

# Variables

```bash
variable "key_name" {
variable "user" {
variable "aws_region" {
variable "aws_instance_type" {
variable "num_of_private_agents" {
variable "num_of_masters" {
variable "owner" {
variable "expiration" {
variable "ip-detect" {
variable "os-init-script" {
variable "instance_disk_size" {
variable "dcos_download_path" {
variable "aws_amis" {
```

# Roadmaps

- [X] Support for AWS
- [X] Support for CoreOS
- [ ] Support for Public Agents
- [ ] Support for specific versions of CoreOS
- [ ] Support for Centos
- [ ] Secondary support for specific versions of Centos
- [ ] Support for RHEL
- [ ] Secondary support for specific versions of RHEL
- [ ] Support for GCP
- [ ] Support for Azure
- [ ] Multi AZ Support
