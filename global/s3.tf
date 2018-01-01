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
    target_prefix = "terraform-state/"
  }

  lifecycle {
    prevent_destroy = true
  }
}

// for logging
resource "aws_s3_bucket" "logs" {
  bucket = "kr.sideeffect.logs"
  acl    = "log-delivery-write"
  policy = "${data.aws_iam_policy_document.aws_s3_bucket_logs.json}"
}

data "aws_iam_policy_document" "aws_s3_bucket_logs" {
  statement {
    sid = "Stmt1498286757157"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::kr.sideeffect.logs/alb/AWSLogs/410655858509/*",
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "${data.aws_elb_service_account.main.arn}",
      ]
    }
  }

  statement {
    sid = "AWSCloudTrailWrite"

    actions = [
      "s3:PutObject*",
    ]

    resources = [
      "arn:aws:s3:::kr.sideeffect.logs/cloudtrail/*",
    ]

    principals = {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid = "AWSCloudTrailAclCheck"

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::kr.sideeffect.logs",
    ]

    principals = {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket" "labs_sideeffect_kr" {
  bucket = "kr.sideeffect.labs"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.labs_sideeffect_kr.json}"

  website {
    index_document = "index.html"
  }
}

data "aws_iam_policy_document" "labs_sideeffect_kr" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::kr.sideeffect.labs/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.labs_sideeffect_kr.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket" "nodejs_sideeffect_kr" {
  bucket = "kr.sideeffect.nodejs"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.nodejs_sideeffect_kr.json}"

  website {
    index_document = "index.html"
  }
}

data "aws_iam_policy_document" "nodejs_sideeffect_kr" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::kr.sideeffect.nodejs/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.nodejs_sideeffect_kr.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket" "test_outsider_ne_kr" {
  bucket = "kr.ne.outsider.test"
  acl    = "private"
}
