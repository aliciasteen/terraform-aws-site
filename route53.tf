data "aws_route53_zone" "zone" {
  count   = var.route53-enabled ? 1 : 0
  zone_id = var.hosted_zone_id
}

resource "aws_route53_record" "route_record" {
  count   = var.route53-enabled ? 1 : 0
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = var.website_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "site_certificate_validation_record" {
  count   = var.route53-enabled ? 1 : 0
  zone_id = data.aws_route53_zone.zone[0].zone_id
  name    = aws_acm_certificate.site_certificate.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.site_certificate.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.site_certificate.domain_validation_options[0].resource_record_value]
  ttl     = 60
}
