data "aws_acm_certificate" "labs_sideeffect_kr" {
  domain   = "labs.sideeffect.kr"
  statuses = ["ISSUED"]
}
