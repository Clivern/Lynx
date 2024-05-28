# Terraform backend configuration for Lynx
## Overview
This directory provide you an example of Terraform code to provisioning resources with **Lynx**. <br/>**Lynx** is a Fast, Secure and Reliable Terraform Backend.

| File name | Description                        |
|-----------|------------------------------------|
| Backend.tf | Terraform Backend configuration example |
| Main.tf | Resources provisioned by Terraform and stored as Terraform state in Lynx |

More details about Terraform HTTP backend in https://developer.hashicorp.com/terraform/language/settings/backends/http

More details about OpenTofu (Open alternative to Terraform) HTTP backend in https://opentofu.org/docs/language/settings/backends/http/

## Before You begin
* You have to create in **Lynx**:
    * add new Project (Monitoring in this example)
    * add new Environment (Prod in this example).
* Username and Password would be unique for each Environment in Project.

## Configuration

In this directory you can find two files:




In Production-ready configurations those file should NOT be located in same directory to avoid TF execution conflicts.


## Usage

### Clone this repo

```zsh
$ git clone https://github.com/Clivern/Lynx.git
$ cd ./terraform-example
```
### Authentificate in **Lynx** 
You can set username and password as Terraform VARIABLES
```zsh
$ export TF_HTTP_USERNAME="vf41bkwj"
$ export TF_HTTP_PASSWORD="2sTb&N*gvyXj"
```
| :warning: WARNING :warning: |
|:----------------------------|
| :boom: Another way is hardcode username and password in 'backend.tf' file. Very bad approach from Security Point of View :boom: |

### Create resources with Terraform in **Lynx** backend
```zsh
$ tf init
$ tf validate
$ tf plan
$ tf apply
```
If you would like to destroy resources in TF state stored in **Lynx** just run
```zsh
$ tf destroy
```

