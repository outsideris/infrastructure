resource "aws_route53_zone" "sideeffect_kr" {
  name = "sideeffect.kr"
}

resource "aws_route53_record" "sideeffect_kr" {
  zone_id = aws_route53_zone.sideeffect_kr.zone_id
  name    = "sideeffect.kr"
  type    = "A"

  alias {
    name                   = aws_route53_record.www_sideeffect_kr.name
    zone_id                = aws_route53_record.www_sideeffect_kr.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_sideeffect_kr" {
  zone_id = aws_route53_zone.sideeffect_kr.zone_id
  name    = "www.sideeffect.kr"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.ecs_services.outputs.side_effect_alb_dns
    zone_id                = data.terraform_remote_state.ecs_services.outputs.side_effect_alb_zone_id
    evaluate_target_health = false
  }
}

# labs
resource "aws_route53_record" "labs_sideeffect_kr" {
  zone_id = aws_route53_zone.sideeffect_kr.zone_id
  name    = "labs.sideeffect.kr"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.labs_sideeffect_kr.domain_name
    zone_id                = aws_cloudfront_distribution.labs_sideeffect_kr.hosted_zone_id
    evaluate_target_health = false
  }
}

# node.js old api documents
resource "aws_route53_record" "nodejs_sideeffect_kr" {
  zone_id = aws_route53_zone.sideeffect_kr.zone_id
  name    = "nodejs.sideeffect.kr"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.nodejs_sideeffect_kr.domain_name
    zone_id                = aws_cloudfront_distribution.nodejs_sideeffect_kr.hosted_zone_id
    evaluate_target_health = false
  }
}

# outsider.ne.kr
resource "aws_route53_zone" "outsider_ne_kr" {
  name = "outsider.ne.kr"
}

resource "aws_route53_record" "blog_outsider_ne_kr" {
  zone_id = aws_route53_zone.outsider_ne_kr.zone_id
  name    = "blog.outsider.ne.kr"
  type    = "A"
  ttl     = "300"
  records = ["13.125.73.169"]
}

resource "aws_route53_record" "outsider_ne_kr" {
  zone_id = aws_route53_zone.outsider_ne_kr.zone_id
  name    = "outsider.ne.kr"
  type    = "A"
  ttl     = "300"
  records = ["13.125.73.169"]
}

resource "aws_route53_record" "www_outsider_ne_kr" {
  zone_id = aws_route53_zone.outsider_ne_kr.zone_id
  name    = "www.outsider.ne.kr"
  type    = "A"
  ttl     = "300"
  records = ["13.125.73.169"]
}

resource "aws_route53_record" "blog_outsider_ne_kr_google_searchconsole" {
  zone_id = aws_route53_zone.outsider_ne_kr.zone_id
  name    = "blog.outsider.ne.kr"
  type    = "TXT"
  ttl     = "300"
  records = ["google-site-verification=5B1OON1Y0sF-uyT3uCgHG4ugUvq8moJWjdFjTdzHF2M"]
}

# outsider.dev
resource "aws_route53_zone" "outsider_dev" {
  name = "outsider.dev"
}

resource "aws_route53_record" "teslamate_outsider_dev" {
  zone_id = aws_route53_zone.outsider_dev.zone_id
  name    = "teslamate.outsider.dev"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.ap_ne1_ec2.outputs.teslamate_ec2_ip]
}

resource "aws_route53_record" "tesla_grafana_outsider_dev" {
  zone_id = aws_route53_zone.outsider_dev.zone_id
  name    = "tesla-grafana.outsider.dev"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.ap_ne1_ec2.outputs.teslamate_ec2_ip]
}
