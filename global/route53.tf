resource "aws_route53_zone" "sideeffect_kr" {
  name = "sideeffect.kr"
}

data "aws_acm_certificate" "sideeffect_kr" {
  domain   = "*.sideeffect.kr"
  statuses = ["ISSUED"]
}

resource "aws_route53_record" "sideeffect_kr" {
  zone_id = "${aws_route53_zone.sideeffect_kr.zone_id}"
  name = "sideeffect.kr"
  type = "A"

  alias {
    name = "${data.terraform_remote_state.ecs_services.side_effect_alb_dns}"
    zone_id = "${data.terraform_remote_state.ecs_services.side_effect_alb_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_sideeffect_kr" {
  zone_id = "${aws_route53_zone.sideeffect_kr.zone_id}"
  name = "www.sideeffect.kr"
  type = "A"

  alias {
    name = "${data.terraform_remote_state.ecs_services.side_effect_alb_dns}"
    zone_id = "${data.terraform_remote_state.ecs_services.side_effect_alb_zone_id}"
    evaluate_target_health = false
  }
}
