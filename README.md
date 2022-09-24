# AWS Static Website Terraform module

[![Terraform Registry - latest](https://img.shields.io/badge/Terraform_Registry-latest-2ea44f?style=for-the-badge&logo=terraform)](https://registry.terraform.io/modules/viniciustrainotti/static-website-module/aws/latest?tab=readme)
[![License - Apache](https://img.shields.io/badge/License-Apache-2ea44f?style=for-the-badge)](https://github.com/viniciustrainotti/terraform-aws-static-website-module/blob/master/LICENSE)

This module provisions AWS S3 buckets with AWS CloudFront configured for static website hosting 
and possibility improve security with AWS WAF and AWS domain configuration with AWS ACM & AWS Route53 optionally.

## Usage

```terraform
module "website" {
  source = "viniciustrainotti/static-website-module/aws"

  aws_profile             = "default"
  domain                  = "example.com"
  application_name        = "example"
  website_path            = "/example/path/react/build"
  subdomains              = ["app", "www"]
  default_root_index_file = "index.html"

  tags = { Application = "example", Environment = "dev" }
}
```

## Examples

- [Basic Example](https://github.com/viniciustrainotti/terraform-aws-static-website-module/tree/master/examples/basic)
- [Complete Example](https://github.com/viniciustrainotti/terraform-aws-static-website-module/tree/master/examples/complete)

## Requirements

| Name      | Version |
|:----------|:-------:|
| terraform | 1.2.3   |
| aws-cli   | 2.4.2   |

## Providers

| Name | Version   |
|:-----|:---------:|
| aws  | >= 4.19.0 |

## Modules

No modules.

## Resources

| Name                                                              | Type        |
|:----------------------------------------------------------------- |:-----------:|
| aws_route53_zone.this                                             | data source |
| aws_iam_policy_document                                           | data source |
| aws_acm_certificate.this                                          | resource    |
| aws_acm_certificate_validation.this                               | resource    |
| aws_cloudfront_origin_access_identity.this                        | resource    |
| aws_cloudfront_distribution.this                                  | resource    |
| aws_route53_record.website                                        | resource    |
| aws_route53_record.subdomain                                      | resource    |
| aws_route53_record.cert_validation                                | resource    |
| aws_s3_bucket_policy.react_app_bucket_policy                      | resource    |
| aws_s3_bucket.logs                                                | resource    |
| aws_s3_bucket_acl.acl_logs                                        | resource    |
| aws_s3_bucket.website                                             | resource    |
| aws_s3_bucket_public_access_block.block_public_access             | resource    |
| aws_s3_bucket_versioning.versioning                               | resource    |
| aws_s3_bucket_acl.acl_website                                     | resource    |
| aws_s3_bucket_website_configuration.bucket_website_configuration  | resource    |
| aws_s3_bucket_logging.logging                                     | resource    |
| aws_s3_object.this                                                | resource    |

## Inputs

| Name                    | Description                                       | Type            | Default       | Required |
|:----------------------- |:------------------------------------------------- |:--------------- |:------------- |:-------- |
| application_name        | Define application name to set default resources  | `string`        | `"default"`   | yes      |
| website_path            | Website path to project files to uploads it       | `string`        | `""`          | yes      |
| aws_profile             | Profile set of your AWS account                   | `string`        | `"default"`   | no       | 
| domain                  | Set root domain                                   | `string`        | `""`          | no       |
| subdomains ¹            | List contains subdomains                          | `list(string)`  | `[]`          | no       |
| tags                    | Define tags to set in resources                   | `map(string)`   | `{}`          | no       |
| default_root_index_file | Default root index file to resources              | `string`        | `"index.html"`| no       |
| enable_waf              | Enable or disable to create AWS WAF resource      | `bool`          | `false`       | no       |

¹ If domain is not set, remove it.

## Outputs

| Name            | Description       |
|:--------------- |:-----------------:|
| website-url     | Website URL       |
| bucket_logs     | Bucket Logs ID    |
| bucket_website  | Bucket Website ID |
| distribution-id | Cloudfront ID     |
| cdn-url         | Cloudfront URL    |

## Authors

Module is maintained by [Vinícius Trainotti](https://github.com/viniciustrainotti) with help [from these awesome contributors](https://github.com/viniciustrainotti/terraform-aws-static-website-module/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/viniciustrainotti/terraform-aws-static-website-module/blob/master/LICENSE) for full details.
