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
