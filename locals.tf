locals {
  has_domain       = var.domain != ""
  domain           = local.has_domain ? var.domain : random_pet.website.id
  regional_domain  = aws_s3_bucket.website.bucket_regional_domain_name
  website_filepath = "/opt/projects/react/learn-githubactions-react"
  app_name_default = "${var.app_name}-${var.environment}"

  common_tags = {
    Project     = "Application React"
    Environment = var.environment
  }
}
