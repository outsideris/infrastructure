module "side_effect_alb" {
  source = "./modules/alb"
  name   = "side-effect"

  subnet_ids = [
    "${data.terraform_remote_state.vpc.side_effect_public_subnets}",
  ]

  security_groups = [
    "${data.terraform_remote_state.vpc.side_effect_default_sg}",
    "${data.terraform_remote_state.vpc.side_effect_ephemeral_ports_sg}",
    "${data.terraform_remote_state.vpc.side_effect_public_web_sg}",
  ]

  log_bucket  = "${data.terraform_remote_state.global.s3_bucket_logs_bucket}"
  environment = "production"
}

# http
module "side_effect_alb_http" {
  source           = "./modules/alb-listener"
  alb_arn          = "${module.side_effect_alb.arn}"
  port             = "80"
  protocol         = "HTTP"
  target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
}

resource "aws_alb_listener_rule" "popular_convention_http" {
  listener_arn = "${module.side_effect_alb_http.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/popularconvention/*"]
  }
}

resource "aws_alb_listener_rule" "well_known_http" {
  listener_arn = "${module.side_effect_alb_http.arn}"
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.well_known.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/.well-known/*"]
  }
}

# https
module "side_effect_alb_https" {
  source           = "./modules/alb-listener"
  alb_arn          = "${module.side_effect_alb.arn}"
  port             = "443"
  protocol         = "HTTPS"
  certificate_arn  = "${data.terraform_remote_state.global.sideeffect_kr_certificate_arn}"
  target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
}

resource "aws_alb_listener_rule" "popular_convention_https" {
  listener_arn = "${module.side_effect_alb_https.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/popularconvention/*"]
  }
}

resource "aws_alb_listener_rule" "well_known_https" {
  listener_arn = "${module.side_effect_alb_https.arn}"
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.well_known.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/.well-known/*"]
  }
}

resource "aws_alb_listener_rule" "vault_https" {
  listener_arn = "${module.side_effect_alb_https.arn}"
  priority     = 300

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.vault.arn}"
  }

  condition {
    field  = "host-header"
    values = ["vault.sideeffect.kr"]
  }
}
