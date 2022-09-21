module "website" {
  source = "./modules/aws-static-website-configuration"

  aws_profile             = var.aws_profile
  domain                  = var.domain
  application_name        = "${var.app_name}-${var.environment}"
  website_path            = var.website_path
  subdomains              = var.subdomains
  default_root_index_file = var.default_root_index_file

  tags = { Application = var.app_name, Environment = var.environment }
}
