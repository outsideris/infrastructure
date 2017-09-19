resource "aws_cloudtrail" "ap_northeast_1" {
  name                          = "ap-northeast-1"
  s3_bucket_name                = "${aws_s3_bucket.logs.id}"
  s3_key_prefix                 = "cloudtrail"
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = false
  tags                          = {}
}
