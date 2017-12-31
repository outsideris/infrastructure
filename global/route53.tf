resource "aws_route53_zone" "sideeffect_kr" {
  name = "sideeffect.kr"
}

resource "aws_route53_record" "sideeffect_kr" {
  zone_id = "${aws_route53_zone.sideeffect_kr.zone_id}"
  name    = "sideeffect.kr"
  type    = "A"

  alias {
    name                   = "${aws_route53_record.www_sideeffect_kr.name}"
    zone_id                = "${aws_route53_record.www_sideeffect_kr.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_sideeffect_kr" {
  zone_id = "${aws_route53_zone.sideeffect_kr.zone_id}"
  name    = "www.sideeffect.kr"
  type    = "A"

  alias {
    name                   = "${data.terraform_remote_state.ecs_services.side_effect_alb_dns}"
    zone_id                = "${data.terraform_remote_state.ecs_services.side_effect_alb_zone_id}"
    evaluate_target_health = false
  }
}

# labs
resource "aws_route53_record" "labs_sideeffect_kr" {
  zone_id = "${aws_route53_zone.sideeffect_kr.zone_id}"
  name    = "labs.sideeffect.kr"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.labs_sideeffect_kr.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.labs_sideeffect_kr.hosted_zone_id}"
    evaluate_target_health = false
  }
}

# node.js old api documents
resource "aws_route53_record" "nodejs_sideeffect_kr" {
  zone_id = "${aws_route53_zone.sideeffect_kr.zone_id}"
  name    = "nodejs.sideeffect.kr"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.nodejs_sideeffect_kr.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.nodejs_sideeffect_kr.hosted_zone_id}"
    evaluate_target_health = false
  }
}

# ACM certificates
data "aws_acm_certificate" "sideeffect_kr" {
  domain   = "*.sideeffect.kr"
  statuses = ["ISSUED"]
}
