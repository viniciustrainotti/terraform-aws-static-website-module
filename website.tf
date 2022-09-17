module "website_s3_bucket" {
  source = "./modules/aws-static-website-configuration"

  aws_profile      = var.aws_profile
  domain           = var.domain
  app_name_default = local.app_name_default
  website_path     = var.website_path

  common_tags = local.common_tags
}
