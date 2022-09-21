locals {
  has_domain         = var.domain != ""
  subdomains         = [for s in var.subdomains : "${s}.${var.domain}"]
  cloudfront_aliases = concat([var.domain], local.subdomains)
}

provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile
  alias   = "us-east-1"
}
