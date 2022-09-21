# AWS Static Website Terraform module

This module provisions AWS S3 buckets with AWS CloudFront configured for static website hosting 
and AWS domain configuration with AWS ACM & AWS Route53 optionally.

## Usage

```terraform
module "website" {
  source = "github.com/viniciustrainotti/terraform-s3-cloudfront"

  aws_profile             = "default"
  domain                  = "example.com"
  application_name        = "example"
  website_path            = "/example/path/react/build"
  subdomains              = ["app", "www"]
  default_root_index_file = "index.html"

  tags = { Application = "example", Environment = "dev" }
}
```

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
| aws_profile             | Profile set of your AWS account                   | `string`        | `"default"`   | no       | 
| domain                  | Set root domain                                   | `string`        | `""`          | no       |
| website_path            | Website path to project to uploads files          | `string`        |               | yes      |
| tags                    | Define tags to set in resources                   | `map(string)`   | `{}`          | no       |
| application_name        | Define application name to set default resources  | `string`        |               | yes      | 
| default_root_index_file | Default root index file to resources              | `string`        | `"index.html"`| no       |
| subdomains              | List contains subdomains                          | `list(string)`  | `[]`          | no       |

## Outputs

| Name            | Description       |
|:--------------- |:-----------------:|
| website-url     | Website URL       |
| bucket_logs     | Bucket logs id    |
| bucket_website  | Bucket website id |
| distribution-id | Cloudfront Id     |
| cdn-url         | Cloudfront URL    |

## Authors

Module is maintained by [Vinícius Trainotti](https://github.com/viniciustrainotti) with help [from these awesome contributors](https://github.com/viniciustrainotti/terraform-s3-cloudfront/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/viniciustrainotti/terraform-s3-cloudfront/blob/master/modules/aws-static-website-configuration/LICENSE) for full details.
