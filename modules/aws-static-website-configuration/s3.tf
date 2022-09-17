resource "aws_s3_bucket_policy" "react_app_bucket_policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_allow_access_from_cf.json
}

data "aws_iam_policy_document" "s3_allow_access_from_cf" {
  version = "2008-10-17"
  statement {
    sid = "PublicReadForGetBucketObjects"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.this.id}"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]
  }
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${var.app_name_default}-logs"
  force_destroy = !(var.domain != "")

  tags = var.common_tags

}

resource "aws_s3_bucket_acl" "acl_logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "website" {
  bucket        = var.app_name_default
  force_destroy = !(var.domain != "")

  tags = var.common_tags
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
  for_each = "${var.website_path}" != "" ? fileset("${var.website_path}", "**") : []

  bucket       = aws_s3_bucket.website.id
  key          = each.value
  source       = "${var.website_path}/${each.value}"
  etag         = filemd5("${var.website_path}/${each.value}")
  content_type = lookup(var.file_types, regex("\\.[^\\.]+\\z", "${var.website_path}/${each.value}"), var.default_file_type)
}