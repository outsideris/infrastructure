resource "aws_cloudfront_origin_access_identity" "labs_sideeffect_kr" {
  comment = "labs.sideeffect.kr Cloudfront"
}

resource "aws_cloudfront_distribution" "labs_sideeffect_kr" {
  origin {
    domain_name = "${aws_s3_bucket.labs_sideeffect_kr.website_endpoint}"
    origin_path = ""
    origin_id   = "S3-${aws_s3_bucket.labs_sideeffect_kr.bucket}"

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  aliases             = ["labs.sideeffect.kr"]
  comment             = "labs.sideeffect.kr"
  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"
  http_version        = "http2"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.labs_sideeffect_kr.bucket}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    max_ttl                = 360
    default_ttl            = 60
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn      = "${data.terraform_remote_state.us_east_1.labs_sideeffect_kr_certificate_arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

resource "aws_cloudfront_origin_access_identity" "nodejs_sideeffect_kr" {
  comment = "nodejs.sideeffect.kr Cloudfront"
}

resource "aws_cloudfront_distribution" "nodejs_sideeffect_kr" {
  origin {
    domain_name = "${aws_s3_bucket.nodejs_sideeffect_kr.website_endpoint}"
    origin_path = ""
    origin_id   = "S3-${aws_s3_bucket.nodejs_sideeffect_kr.bucket}"

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  aliases             = ["nodejs.sideeffect.kr"]
  comment             = "nodejs.sideeffect.kr"
  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"
  http_version        = "http2"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.nodejs_sideeffect_kr.bucket}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    max_ttl                = 360
    default_ttl            = 60
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn      = "${data.terraform_remote_state.us_east_1.nodejs_sideeffect_kr_certificate_arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
