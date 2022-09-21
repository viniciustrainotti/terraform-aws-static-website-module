# Basic Example

This example contains the requirements inputs to Terraform configuration that can be used to provision
cloud infrastructure resources on AWS to host a static website hosting application.

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

After changing the values to necessary to correctly execute, following to steps below:

```sh
$ terraform init
$ terraform plan -out="tfplan.out"
$ terraform apply "tfplan.out"
```

To tear down the provisioned infrastructure, use the following commands:

```sh
$ terraform destroy
```
