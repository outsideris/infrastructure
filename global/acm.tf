// *.sideeffect.kr
resource "aws_acm_certificate" "wild_sideeffect_kr" {
  domain_name       = "*.sideeffect.kr"
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "wild_sideeffect_kr_validation" {
  name    = aws_acm_certificate.wild_sideeffect_kr.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.wild_sideeffect_kr.domain_validation_options.0.resource_record_type
  zone_id = aws_route53_zone.sideeffect_kr.zone_id
  records = [aws_acm_certificate.wild_sideeffect_kr.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "wild_sideeffect_kr" {
  certificate_arn         = aws_acm_certificate.wild_sideeffect_kr.arn
  validation_record_fqdns = [aws_route53_record.wild_sideeffect_kr_validation.fqdn]
}
