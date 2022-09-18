# Terraform Static Website Infrastructure

This repository presents the use of a module with an infrastructure for hosting a React application with AWS S3 and AWS CloudFront with the possibility of creating domain aliases with AWS Route53 and generating a certificate with Amazon Certificate Manager.

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

Assuming you have already configured a profile in aws-cli with proper permissions to run terraform. You should change values `dev.tfvars` file in environments folder.

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