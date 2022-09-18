# Terraform Static Website Infrastructure

This repository contains Terraform configuration that can be used to provision
cloud infrastructure resources on AWS to host a React application.

The AWS services used are CloudFront and S3. If a domain name is provided,
aliases are created using Route53, and a cerificate is requested from Amazon
Certificate Manager.

## Requirements

| Name      | Version |
|:----------|:-------:|
| terraform | 1.2.3   |
| aws-cli   | 2.4.2   |

## Providers

| Name | Version   |
|:-----|:---------:|
| aws  | >= 4.19.0 |


## Usage

**DISCLAIMER:** The following commands assume you have already configured a
profile in aws-cli with proper permissions to run this Terraform configuration.

You should change the values in the `dev.tfvars` file, in the `environments`
folder.

After change values, execute following steps

```sh
$ terraform init
$ terraform workspace new dev
$ terraform plan -var-file="environments/dev.tfvars" -out="tfplan.out"
$ terraform apply "tfplan.out"
```

To tear down infrastructure to use below command.

```sh
$ terraform workspace select dev
$ terraform destroy -var-file"environments/dev.tfvars"
```