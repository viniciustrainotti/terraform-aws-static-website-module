terraform {
  required_version = "~> 1.2.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.19.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile
  alias   = "us-east-1"
}

module "website" {
  source = "../../"

  aws_profile             = var.aws_profile
  domain                  = var.domain
  application_name        = "${var.app_name}-${var.environment}"
  website_path            = var.website_path
  subdomains              = var.subdomains
  default_root_index_file = var.default_root_index_file
  enable_waf              = var.enable_waf

  tags = { Application = var.app_name, Environment = var.environment }
}
