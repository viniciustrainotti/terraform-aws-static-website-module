output "website-urls" {
  value = length(var.domains) > 0 ? var.domains : aws_cloudfront_distribution.this.domain_name
}

output "bucket_logs" {
  value = aws_s3_bucket.logs.bucket_domain_name
}

output "bucket_website" {
  value = aws_s3_bucket.website.id
}

output "website_regional_domain" {
  value = aws_s3_bucket.website.bucket_regional_domain_name
}

output "cdn-url" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "distribution-id" {
  value = aws_cloudfront_distribution.this.id
}
