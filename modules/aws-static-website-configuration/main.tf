locals {
  has_domain         = var.domain != ""
  cloudfront_aliases = var.aliases_cf_www ? [var.domain, "www.${var.domain}"] : [var.domain]
  create_record_subdomain = local.has_domain && var.aliases_cf_www
}

provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile
  alias   = "us-east-1"
}
