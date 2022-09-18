resource "aws_acm_certificate" "this" {
  count = length(var.domains) > 0 ? 1 : 0

  provider = aws.us-east-1

  domain_name               = var.domains[0]
  validation_method         = "DNS"
  subject_alternative_names = [for d in var.domains : "*.${d}"]
}

resource "aws_acm_certificate_validation" "this" {
  for_each = aws_acm_certificate.this

  provider = aws.us-east-1

  certificate_arn         = each.value.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
