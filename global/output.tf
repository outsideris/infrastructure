output "iam_user_apex_basic_name" {
  value = "${aws_iam_user.apex-basic.name}"
}

output "iam_user_apex_basic_arn" {
  value = "${aws_iam_user.apex-basic.arn}"
}

output "iam_user_outsider_name" {
  value = "${aws_iam_user.outsider.name}"
}

output "iam_user_outsider_arn" {
  value = "${aws_iam_user.outsider.arn}"
}

output "iam_role_ecs_service_role_arn" {
  value = "${aws_iam_role.ecs_service_role.arn}"
}

output "route53_sideeffect_kr_zone_id" {
  value = "${aws_route53_zone.sideeffect_kr.zone_id}"
}

output "sideeffect_kr_certificate_arn" {
  value = "${data.aws_acm_certificate.sideeffect_kr.arn}"
}

output "s3_bucket_logs_bucket" {
  value = "${aws_s3_bucket.logs.bucket}"
}
