resource "aws_acm_certificate" "this" {
  count = var.domain != "" ? 1 : 0

  provider = aws.us-east-1

  domain_name               = var.domain
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.domain}"]
}

resource "aws_acm_certificate_validation" "this" {
  count = var.domain != "" ? 1 : 0

  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.this[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
