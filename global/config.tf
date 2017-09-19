resource "aws_config_config_rule" "ap_northeast_1_cloudtrail_enabled" {
  name = "cloudtrail-enabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  depends_on = ["aws_config_configuration_recorder.ap_northeast_1"]
}

resource "aws_config_config_rule" "ap_northeast_1_ec2_instances_in_vpc" {
  name = "ec2-instances-in-vpc"

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }

  depends_on = ["aws_config_configuration_recorder.ap_northeast_1"]
}

resource "aws_config_configuration_recorder" "ap_northeast_1" {
  name     = "aws-config-ap-northeast-1"
  role_arn = "${aws_iam_role.config_service.arn}"
}

resource "aws_config_configuration_recorder_status" "ap_northeast_1" {
  name       = "${aws_config_configuration_recorder.ap_northeast_1.name}"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.ap_northeast_1"]
}

resource "aws_config_delivery_channel" "ap_northeast_1" {
  name           = "${aws_config_configuration_recorder.ap_northeast_1.name}"
  s3_bucket_name = "${aws_s3_bucket.logs.bucket}"
  s3_key_prefix  = "config"
  sns_topic_arn  = "${data.terraform_remote_state.vpc.sns_topic_config_service_arn}"
  depends_on     = ["aws_config_configuration_recorder.ap_northeast_1"]
}
