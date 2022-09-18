variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "viniciustrainotti"
}

variable "domain" {
  type        = string
  description = ""
  default     = ""
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

variable "app_name" {
  type        = string
  description = "App name"
  default     = "Application React"
}

variable "website_path" {
  type        = string
  description = "Website path to project to uploads files"
}

variable "has_aliases_cf_www" {
  type = bool
  description = "To create www subdomain or only root domain"
  default = false
}

variable "default_root_index_file" {
  type = string
  description = "Default root index file to resources"
  default = "index.html"
}
