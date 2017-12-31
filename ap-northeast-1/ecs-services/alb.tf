module "side_effect_alb" {
  source = "../modules/alb"
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
  source           = "../modules/alb-listener"
  alb_arn          = "${module.side_effect_alb.arn}"
  port             = "80"
  protocol         = "HTTP"
  target_group_arn = "${module.ecs_service_popular_convention.target_group_arn}"
}

module "side_effect_alb_http_rule_popular_convention" {
  source           = "../modules/alb-listener-rule"
  listener_arn     = "${module.side_effect_alb_http.arn}"
  priority         = 100
  target_group_arn = "${module.ecs_service_popular_convention.target_group_arn}"
  condition_field  = "path-pattern"
  condition_values = ["/popularconvention/*"]
}

module "side_effect_alb_http_rule_well_known" {
  source           = "../modules/alb-listener-rule"
  listener_arn     = "${module.side_effect_alb_http.arn}"
  priority         = 200
  target_group_arn = "${module.ecs_service_well_known.target_group_arn}"
  condition_field  = "path-pattern"
  condition_values = ["/.well-known/*"]
}

# https
module "side_effect_alb_https" {
  source           = "../modules/alb-listener"
  alb_arn          = "${module.side_effect_alb.arn}"
  port             = "443"
  protocol         = "HTTPS"
  certificate_arn  = "${data.terraform_remote_state.global.sideeffect_kr_certificate_arn}"
  target_group_arn = "${module.ecs_service_popular_convention.target_group_arn}"
}

module "side_effect_alb_https_rule_popular_convention" {
  source           = "../modules/alb-listener-rule"
  listener_arn     = "${module.side_effect_alb_https.arn}"
  priority         = 100
  target_group_arn = "${module.ecs_service_popular_convention.target_group_arn}"
  condition_field  = "path-pattern"
  condition_values = ["/popularconvention/*"]
}

module "side_effect_alb_https_rule_well_known" {
  source           = "../modules/alb-listener-rule"
  listener_arn     = "${module.side_effect_alb_https.arn}"
  priority         = 200
  target_group_arn = "${module.ecs_service_well_known.target_group_arn}"
  condition_field  = "path-pattern"
  condition_values = ["/.well-known/*"]
}

