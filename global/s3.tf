resource "aws_s3_bucket" "nodejs-ko" {
  bucket = "nodejs-ko"
  acl    = "private"
}

resource "aws_s3_bucket" "nplambda-test-1476121205447" {
  bucket = "nplambda.test.1476121205447"
  acl    = "private"
}

resource "aws_s3_bucket" "vault-test-outsider" {
  bucket = "vault-test-outsider"
  acl    = "private"
}

// sideeffect 용 terraform state
resource "aws_s3_bucket" "terraform-state" {
  bucket = "kr.sideeffect.terraform.state"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags {
    Name        = "terraform state"
    Environment = "Prod"
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  lifecycle {
    prevent_destroy = true
  }
}

// 로깅용 버킷
resource "aws_s3_bucket" "logs" {
  bucket = "kr.sideeffect.logs"
  acl    = "log-delivery-write"
}
