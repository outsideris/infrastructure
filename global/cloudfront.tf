resource "aws_cloudfront_origin_access_identity" "labs_sideeffect_kr" {
  comment = "labs.sideeffect.kr Cloudfront"
}

resource "aws_cloudfront_distribution" "labs_sideeffect_kr" {
  origin {
    domain_name = "${aws_s3_bucket.labs_sideeffect_kr.bucket_domain_name}"
    origin_path = ""
    origin_id = "labs_sideeffect_kr"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.labs_sideeffect_kr.cloudfront_access_identity_path}"
    }
  }

  aliases = ["labs.sideeffect.kr"]
  comment = "labs.sideeffect.kr"
  enabled = true
  is_ipv6_enabled = false
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "labs_sideeffect_kr"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl = 0
    max_ttl = 360
    default_ttl = 60
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
    acm_certificate_arn = "${data.terraform_remote_state.us_east_1.labs_sideeffect_kr_certificate_arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
