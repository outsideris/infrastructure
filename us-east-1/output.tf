output "labs_sideeffect_kr_certificate_arn" {
  value = "${data.aws_acm_certificate.labs_sideeffect_kr.arn}"
}

output "nodejs_sideeffect_kr_certificate_arn" {
  value = "${data.aws_acm_certificate.nodejs_sideeffect_kr.arn}"
}
