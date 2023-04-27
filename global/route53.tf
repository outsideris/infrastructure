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
  records = [var.blog_instance_ip]
}

resource "aws_route53_record" "outsider_ne_kr" {
  zone_id = aws_route53_zone.outsider_ne_kr.zone_id
  name    = "outsider.ne.kr"
  type    = "A"
  ttl     = "300"
  records = [var.blog_instance_ip]
}

resource "aws_route53_record" "www_outsider_ne_kr" {
  zone_id = aws_route53_zone.outsider_ne_kr.zone_id
  name    = "www.outsider.ne.kr"
  type    = "A"
  ttl     = "300"
  records = [var.blog_instance_ip]
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

resource "aws_route53_record" "outsider_dev_bluesky" {
  zone_id = aws_route53_zone.outsider_dev.zone_id
  name    = "_atproto.outsider.dev"
  type    = "TXT"
  ttl     = "300"
  records = ["did=did:plc:pj47jnzs2epyh6qzrjus3c3j"]
}

resource "aws_route53_record" "teslamate_outsider_dev" {
  zone_id = aws_route53_zone.outsider_dev.zone_id
  name    = "teslamate.outsider.dev"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.digital_ocean.outputs.teslamate_ip]
}

resource "aws_route53_record" "tesla_grafana_outsider_dev" {
  zone_id = aws_route53_zone.outsider_dev.zone_id
  name    = "tesla-grafana.outsider.dev"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.digital_ocean.outputs.teslamate_ip]
}

resource "aws_route53_record" "cluster_outsider_dev" {
  zone_id = aws_route53_zone.outsider_dev.zone_id
  name    = "cluster.outsider.dev"
  type    = "NS"
  ttl     = "300"
  records = aws_route53_zone.cluster_outsider_dev.name_servers
}

resource "aws_route53_record" "cb_outsider_dev" {
  zone_id = aws_route53_zone.outsider_dev.zone_id
  name    = "cb.outsider.dev"
  type    = "NS"
  ttl     = "300"
  records = [
    "ns-1533.awsdns-63.org.",
    "ns-1795.awsdns-32.co.uk.",
    "ns-587.awsdns-09.net.",
    "ns-228.awsdns-28.com.",
  ]
}

# cluster.outsider.dev
resource "aws_route53_zone" "cluster_outsider_dev" {
  name = "cluster.outsider.dev"
}
