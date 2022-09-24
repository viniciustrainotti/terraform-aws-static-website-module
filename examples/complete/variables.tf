variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS Profile"
  type        = string
  default     = "default"
}

variable "domain" {
  description = "Define domain to root domain"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "App name"
  type        = string
  default     = "Application React"
}

variable "website_path" {
  description = "Website path to project to uploads files"
  type        = string
}

variable "default_root_index_file" {
  description = "Default root index file to resources"
  type        = string
  default     = "index.html"
}

variable "subdomains" {
  description = "List contains subdomains"
  type        = list(string)
  default     = []
}

variable "enable_waf" {
  description = "Enable or disable to create AWS WAF resource"
  type        = bool
  default     = false
}