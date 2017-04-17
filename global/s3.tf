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
