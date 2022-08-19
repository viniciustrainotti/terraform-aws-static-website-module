output "website-url" {
  value = local.has_domain ? var.domain : aws_s3_bucket_website_configuration.bucket_website_configuration.website_endpoint
}

output "cdn-url" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "distribution-id" {
  value = aws_cloudfront_distribution.this.id
}
