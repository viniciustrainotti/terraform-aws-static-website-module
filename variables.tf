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