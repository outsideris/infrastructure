resource "aws_alb" "side_effect" {
  name = "side-effect"
  internal = false
  security_groups = [
    "${data.terraform_remote_state.vpc.side_effect_default_sg}",
    "${data.terraform_remote_state.vpc.side_effect_ephemeral_ports_sg}",
    "${data.terraform_remote_state.vpc.side_effect_public_web_sg}",
  ]
  subnets = [
    "${data.terraform_remote_state.vpc.side_effect_public_subnets}"
  ]

  enable_deletion_protection = true

  access_logs {
    bucket = "${data.terraform_remote_state.global.s3_bucket_logs_bucket}"
    prefix = "alb"
  }

  tags {
    Environment = "production"
  }
}

# http
resource "aws_alb_listener" "side_effect_http" {
  load_balancer_arn = "${aws_alb.side_effect.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "popular_convention_http" {
  listener_arn = "${aws_alb_listener.side_effect_http.arn}"
  priority = 100

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/popularconvention/*"]
  }
}

resource "aws_alb_listener_rule" "well_known_http" {
  listener_arn = "${aws_alb_listener.side_effect_http.arn}"
  priority = 200

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.well_known.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/.well-known/*"]
  }
}

# https
resource "aws_alb_listener" "side_effect_https" {
  load_balancer_arn = "${aws_alb.side_effect.arn}"
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "${data.terraform_remote_state.global.sideeffect_kr_certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "popular_convention_https" {
  listener_arn = "${aws_alb_listener.side_effect_https.arn}"
  priority = 100

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/popularconvention/*"]
  }
}

resource "aws_alb_listener_rule" "well_known_https" {
  listener_arn = "${aws_alb_listener.side_effect_https.arn}"
  priority = 200

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.well_known.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/.well-known/*"]
  }
}

resource "aws_alb_listener_rule" "vault_https" {
  listener_arn = "${aws_alb_listener.side_effect_https.arn}"
  priority = 300

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.vault.arn}"
  }

  condition {
    field  = "host-header"
    values = ["vault.sideeffect.kr"]
  }
}
