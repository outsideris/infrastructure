// manage feeds that tweeted from nodejs-ko blog
resource "aws_s3_bucket" "nodejs-ko" {
  bucket = "nodejs-ko"
}

// terraform state for sideeffect
resource "aws_s3_bucket" "terraform-state" {
  bucket = "kr.sideeffect.terraform.state"

  tags = {
    Name        = "terraform state"
    Environment = "Prod"
  }

  lifecycle {
    prevent_destroy = true
  }
}

// for logging
resource "aws_s3_bucket" "logs" {
  bucket = "kr.sideeffect.logs"
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

    principals {
      type = "AWS"

      identifiers = [
        data.aws_elb_service_account.main.arn,
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

    principals {
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

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket" "labs_sideeffect_kr" {
  bucket = "kr.sideeffect.labs"
}

resource "aws_s3_bucket_policy" "labs_sideeffect_kr" {
  bucket = aws_s3_bucket.labs_sideeffect_kr.id
  policy = data.aws_iam_policy_document.labs_sideeffect_kr.json
}

data "aws_iam_policy_document" "labs_sideeffect_kr" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::kr.sideeffect.labs/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.labs_sideeffect_kr.iam_arn]
    }
  }
}

resource "aws_s3_bucket_website_configuration" "labs_sideeffect_kr" {
  bucket = aws_s3_bucket.labs_sideeffect_kr.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket" "nodejs_sideeffect_kr" {
  bucket = "kr.sideeffect.nodejs"
}

resource "aws_s3_bucket_policy" "nodejs_sideeffect_kr" {
  bucket = aws_s3_bucket.nodejs_sideeffect_kr.id
  policy = data.aws_iam_policy_document.nodejs_sideeffect_kr.json
}

data "aws_iam_policy_document" "nodejs_sideeffect_kr" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::kr.sideeffect.nodejs/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.nodejs_sideeffect_kr.iam_arn]
    }
  }
}

resource "aws_s3_bucket_website_configuration" "nodejs_sideeffect_kr" {
  bucket = aws_s3_bucket.nodejs_sideeffect_kr.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket" "test_outsider_ne_kr" {
  bucket = "kr.ne.outsider.test"
}
