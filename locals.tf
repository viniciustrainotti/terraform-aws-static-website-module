locals {
  has_domain       = var.domain != ""
  domain           = local.has_domain ? var.domain : ""
  regional_domain  = aws_s3_bucket.website.bucket_regional_domain_name
  website_filepath = var.website_path
  app_name_default = "${var.app_name}-${var.environment}"

  common_tags = {
    Project     = "Application React"
    Environment = var.environment
  }
}
