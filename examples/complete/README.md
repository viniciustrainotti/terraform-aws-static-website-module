# Complete Example

This example contains Terraform configuration that can be used to provision
cloud infrastructure resources on AWS to host a static website hosting application.

The AWS services used are CloudFront and S3 and to up improve architecture security 
is possibility to enable AWS WAF too. If a domain name is provided, aliases are
created using Route53, and a certificate is requested from Amazon Certificate Manager.

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

After changing the values, execute the following steps:

```sh
$ terraform init
$ terraform workspace new dev
$ terraform plan -var-file="environments/dev.tfvars" -out="tfplan.out"
$ terraform apply "tfplan.out"
```

To tear down the provisioned infrastructure, use the following commands:

```sh
$ terraform workspace select dev
$ terraform destroy -var-file"environments/dev.tfvars"
```
