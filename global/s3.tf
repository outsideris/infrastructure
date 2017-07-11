// manage feeds that tweeted from nodejs-ko blog
resource "aws_s3_bucket" "nodejs-ko" {
  bucket = "nodejs-ko"
  acl    = "private"
}

// terraform state for sideeffect
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

// for logging
resource "aws_s3_bucket" "logs" {
  bucket = "kr.sideeffect.logs"
  acl    = "log-delivery-write"
  policy = <<POLICY
{
  "Id": "Policy1498286768375",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1498286757157",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::kr.sideeffect.logs/alb/AWSLogs/410655858509/*",
      "Principal": {
        "AWS": [
          "582318560864"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "labs_sideeffect_kr" {
  bucket = "kr.sideeffect.labs"
  acl = "private"
  policy = "${data.aws_iam_policy_document.labs_sideeffect_kr.json}"

  website {
    index_document = "index.html"
  }
}
data "aws_iam_policy_document" "labs_sideeffect_kr" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["arn:aws:s3:::kr.sideeffect.labs/*"]

    principals {
      type = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.labs_sideeffect_kr.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket" "nodejs_sideeffect_kr" {
  bucket = "kr.sideeffect.nodejs"
  acl = "private"
  policy = "${data.aws_iam_policy_document.nodejs_sideeffect_kr.json}"

  website {
    index_document = "index.html"
  }
}
data "aws_iam_policy_document" "nodejs_sideeffect_kr" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["arn:aws:s3:::kr.sideeffect.nodejs/*"]

    principals {
      type = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.nodejs_sideeffect_kr.iam_arn}"]
    }
  }
}
