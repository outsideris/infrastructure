data "aws_acm_certificate" "labs_sideeffect_kr" {
  domain   = "labs.sideeffect.kr"
  statuses = ["ISSUED"]
}

data "aws_acm_certificate" "nodejs_sideeffect_kr" {
  domain   = "nodejs.sideeffect.kr"
  statuses = ["ISSUED"]
}
