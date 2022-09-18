data "aws_route53_zone" "dns_zone" {
  for_each = toset(var.domains)
  name     = each.key
}

resource "aws_route53_record" "website" {
  for_each = toset(var.domains)

  name    = each.key
  type    = "A"
  zone_id = data.aws_route53_zone.dns_zone[each.key].zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
  }

  depends_on = [
    aws_cloudfront_distribution.this
  ]
}

resource "aws_route53_record" "www" {
  for_each = toset(var.domains)

  name    = "www.${each.key}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.dns_zone[each.key].zone_id
  ttl     = 300

  records = ["${aws_cloudfront_distribution.this.domain_name}"]
}

resource "aws_route53_record" "cert_validation" {
  provider = aws.us-east-1

  for_each = flatten([for d in var.domains : [
    for dvo in aws_acm_certificate.this[0].domain_validation_options : {
      zone_id = data.aws_route53_zone.dns_zone[d].zone_id
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      value   = dvo.resource_record_value
    }
  ]])

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}
