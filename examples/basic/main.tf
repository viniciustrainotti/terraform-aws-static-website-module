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
  region  = "us-east-1"
  profile = "default"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
  alias   = "us-east-1"
}

module "website" {
  source = "../../"

  application_name = "example"
  website_path     = "/example/path/react/build"
}
