data "template_file" "s3_public_policy" {
  template = file("./templates/policy.json")
  vars = {
    bucket_name = local.app_name_default
    cdn_oai     = aws_cloudfront_origin_access_identity.this.id
  }
}

resource "aws_s3_bucket_policy" "react_app_bucket_policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.template_file.s3_public_policy.rendered
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${local.app_name_default}-logs"
  force_destroy = !local.has_domain

  tags = local.common_tags

}

resource "aws_s3_bucket_acl" "acl_logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "website" {
  bucket        = local.app_name_default
  force_destroy = !local.has_domain

  tags = local.common_tags
}

resource "aws_s3_bucket" "www_redirect" {
  count = local.has_domain ? 1 : 0

  bucket = "www.${local.domain}"
}

resource "aws_s3_bucket_acl" "www_redirect" {
  count = local.has_domain ? 1 : 0

  bucket = aws_s3_bucket.www_redirect[0].id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "www_redirect" {
  count = local.has_domain ? 1 : 0

  bucket = aws_s3_bucket.www_redirect[0].id

  redirect_all_requests_to {
    host_name = local.domain
    protocol  = "https"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "acl_website" {
  bucket = aws_s3_bucket.website.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "bucket_website_configuration" {
  bucket = aws_s3_bucket.website.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.website.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "access/"
}

resource "aws_s3_object" "this" {
  for_each = "${local.website_filepath}/build" != "" ? fileset("${local.website_filepath}/build", "**") : []

  bucket       = aws_s3_bucket.website.id
  key          = each.value
  source       = "${local.website_filepath}/build/${each.value}"
  etag         = filemd5("${local.website_filepath}/build/${each.value}")
  content_type = lookup(var.file_types, regex("\\.[^\\.]+\\z", "${local.website_filepath}/build/${each.value}"), var.default_file_type)
}

