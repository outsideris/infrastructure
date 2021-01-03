// labs.sideeffect.kr
resource "aws_acm_certificate" "labs_sideeffect_kr" {
  domain_name       = "labs.sideeffect.kr"
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "labs_sideeffect_kr_validation" {
  name    = tolist(aws_acm_certificate.labs_sideeffect_kr.domain_validation_options).0.resource_record_name
  type    = tolist(aws_acm_certificate.labs_sideeffect_kr.domain_validation_options).0.resource_record_type
  zone_id = data.terraform_remote_state.global.outputs.route53_sideeffect_kr_zone_id
  records = [tolist(aws_acm_certificate.labs_sideeffect_kr.domain_validation_options).0.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "labs_sideeffect_kr" {
  certificate_arn         = aws_acm_certificate.labs_sideeffect_kr.arn
  validation_record_fqdns = [aws_route53_record.labs_sideeffect_kr_validation.fqdn]
}

// nodejs.sideeffect.kr
resource "aws_acm_certificate" "nodejs_sideeffect_kr" {
  domain_name       = "nodejs.sideeffect.kr"
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "nodejs_sideeffect_kr_validation" {
  name    = tolist(aws_acm_certificate.nodejs_sideeffect_kr.domain_validation_options).0.resource_record_name
  type    = tolist(aws_acm_certificate.nodejs_sideeffect_kr.domain_validation_options).0.resource_record_type
  zone_id = data.terraform_remote_state.global.outputs.route53_sideeffect_kr_zone_id
  records = [tolist(aws_acm_certificate.nodejs_sideeffect_kr.domain_validation_options).0.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "nodejs_sideeffect_kr" {
  certificate_arn         = aws_acm_certificate.nodejs_sideeffect_kr.arn
  validation_record_fqdns = [aws_route53_record.nodejs_sideeffect_kr_validation.fqdn]
}
