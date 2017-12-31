# users

## for apex
resource "aws_iam_user" "apex-basic" {
  name          = "apex-basic"
  path          = "/"
  force_destroy = true
}

## it's me
resource "aws_iam_user" "outsider" {
  name          = "outsider"
  path          = "/"
  force_destroy = true
}

# roles
resource "aws_iam_role" "nodejs-ko-twitter_lambda_function" {
  name               = "nodejs-ko-twitter_lambda_function"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.nodejs-ko-twitter_lambda_function.json}"
}

data "aws_iam_policy_document" "nodejs-ko-twitter_lambda_function" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecsInstanceRole"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_instance_role.json}"
}

data "aws_iam_policy_document" "ecs_instance_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "ecs_instance_role" {
  name       = "AmazonEC2ContainerServiceforEC2Role"
  roles      = ["${aws_iam_role.ecs_instance_role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "ecsServiceRole"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_service_role.json}"
}

data "aws_iam_policy_document" "ecs_service_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "ecs_service_role" {
  name       = "AmazonEC2ContainerServiceforEC2Role"
  roles      = ["${aws_iam_role.ecs_service_role.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

## a role for AWS config
resource "aws_iam_role" "config_service" {
  name               = "config-service"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.config_service.json}"
}

data "aws_iam_policy_document" "config_service" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals = {
      type = "Service"

      identifiers = [
        "config.amazonaws.com",
      ]
    }
  }
}

# policy
resource "aws_iam_policy" "apex-default" {
  name        = "apex-default"
  path        = "/"
  description = "apex default"
  policy      = "${data.aws_iam_policy_document.apex-default.json}"
}

data "aws_iam_policy_document" "apex-default" {
  statement {
    actions = [
      "iam:CreateRole",
      "iam:CreatePolicy",
      "iam:AttachRolePolicy",
      "iam:PassRole",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:DescribeInstances",
      "ec2:AttachNetworkInterface",
      "autoscaling:CompleteLifecycleAction",
      "lambda:GetFunction",
      "lambda:UpdateFunctionConfiguration",
      "lambda:CreateFunction",
      "lambda:DeleteFunction",
      "lambda:InvokeFunction",
      "lambda:GetFunctionConfiguration",
      "lambda:UpdateFunctionCode",
      "lambda:CreateAlias",
      "lambda:UpdateAlias",
      "lambda:GetAlias",
      "lambda:ListVersionsByFunction",
      "lambda:AddPermission",
      "lambda:GetPolicy",
      "lambda:RemovePermission",
      "logs:FilterLogEvents",
      "cloudwatch:GetMetricStatistics",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "apigateway:*",
      "iam:*",
      "events:*",
      "s3:*",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "nodejs-ko-twitter_lambda_logs" {
  name        = "nodejs-ko-twitter_lambda_logs"
  path        = "/"
  description = "Allow lambda_function to utilize CloudWatchLogs. Created by apex(1)."
  policy      = "${data.aws_iam_policy_document.nodejs-ko-twitter_lambda_logs.json}"
}

data "aws_iam_policy_document" "nodejs-ko-twitter_lambda_logs" {
  statement {
    actions = [
      "logs:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "config_service_delivery_permission" {
  name        = "config-service-delivery-permission"
  path        = "/"
  description = "Allow AWS Config to delivery logs"
  policy      = "${data.aws_iam_policy_document.config_service_delivery_permission.json}"
}

data "aws_iam_policy_document" "config_service_delivery_permission" {
  statement {
    actions = [
      "s3:PutObject*",
    ]

    resources = [
      "${aws_s3_bucket.logs.arn}/config/*",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "${aws_s3_bucket.logs.arn}",
    ]
  }

  statement {
    actions = [
      "sns:Publish",
    ]

    resources = [
      "${data.terraform_remote_state.vpc.sns_topic_config_service_arn}",
    ]
  }
}

# policy attachment
resource "aws_iam_policy_attachment" "apex-default-policy-attachment" {
  name       = "apex-default-policy-attachment"
  policy_arn = "${aws_iam_policy.apex-default.arn}"
  groups     = ["${aws_iam_group.apex.name}"]
  users      = []
  roles      = []
}

resource "aws_iam_policy_attachment" "nodejs-ko-twitter_lambda_logs-policy-attachment" {
  name       = "nodejs-ko-twitter_lambda_logs-policy-attachment"
  policy_arn = "${aws_iam_policy.nodejs-ko-twitter_lambda_logs.arn}"
  groups     = []
  users      = []
  roles      = ["${aws_iam_role.nodejs-ko-twitter_lambda_function.name}"]
}

resource "aws_iam_policy_attachment" "AWSLambdaFullAccess-policy-attachment" {
  name       = "AWSLambdaFullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
  groups     = []
  users      = ["${aws_iam_user.outsider.name}"]
  roles      = []
}

resource "aws_iam_policy_attachment" "IAMFullAccess-policy-attachment" {
  name       = "IAMFullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  groups     = []
  users      = ["${aws_iam_user.outsider.name}"]
  roles      = []
}

resource "aws_iam_policy_attachment" "AmazonS3FullAccess-policy-attachment" {
  name       = "AmazonS3FullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  groups     = []
  users      = ["${aws_iam_user.outsider.name}"]
  roles      = ["${aws_iam_role.nodejs-ko-twitter_lambda_function.name}"]
}

resource "aws_iam_policy_attachment" "AdministratorAccess-policy-attachment" {
  name       = "AdministratorAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  groups     = []
  users      = ["${aws_iam_user.outsider.name}"]
  roles      = []
}

resource "aws_iam_policy_attachment" "AWSConfigRole-policy-attachment" {
  name       = "AWSConfigRole-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
  groups     = []
  users      = []
  roles      = ["${aws_iam_role.config_service.name}"]
}

resource "aws_iam_policy_attachment" "config_service_delivery_permission_attachment" {
  name       = "config-service-delivery-permission-attachment"
  policy_arn = "${aws_iam_policy.config_service_delivery_permission.arn}"
  groups     = []
  users      = []
  roles      = ["${aws_iam_role.config_service.name}"]
}

# group
resource "aws_iam_group" "apex" {
  name = "apex"
  path = "/"
}

resource "aws_iam_group_membership" "apex" {
  name  = "apex-group-membership"
  users = ["${aws_iam_user.apex-basic.name}"]
  group = "${aws_iam_group.apex.name}"
}

# instance profiles
resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "ecsInstanceRole"
  role = "${aws_iam_role.ecs_instance_role.name}"
}
