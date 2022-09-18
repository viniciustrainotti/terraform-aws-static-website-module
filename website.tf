module "website" {
  source = "./modules/aws-static-website-configuration"

  aws_profile      = var.aws_profile
  domain           = var.domain
  application_name = "${var.app_name}-${var.environment}"
  website_path     = var.website_path
  aliases_cf_www   = var.has_aliases_cf_www
  default_root_index_file = var.default_root_index_file

  tags = local.common_tags
}
