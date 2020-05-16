resource "aws_acm_certificate" "site_certificate" {
  provider          = aws.useast1
  domain_name       = var.website_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "site_certificate_validation" {
  count                   = var.route53-enabled ? 1 : 0
  provider                = aws.useast1
  certificate_arn         = aws_acm_certificate.site_certificate.arn
  validation_record_fqdns = [aws_route53_record.site_certificate_validation_record.fqdn]
}
