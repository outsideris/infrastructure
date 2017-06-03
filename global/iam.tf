# users

## for apex
resource "aws_iam_user" "apex-basic" {
  name = "apex-basic"
  path = "/"
}

## it's me
resource "aws_iam_user" "outsider" {
  name = "outsider"
  path = "/"
}

# roles
resource "aws_iam_role" "nodejs-ko-twitter_lambda_function" {
  name = "nodejs-ko-twitter_lambda_function"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.nodejs-ko-twitter_lambda_function.json}"
}
data "aws_iam_policy_document" "nodejs-ko-twitter_lambda_function" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals = {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "sideeffect_lambda_function" {
  name = "sideeffect_lambda_function"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.sideeffect_lambda_function.json}"
}
data "aws_iam_policy_document" "sideeffect_lambda_function" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals = {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# policy
resource "aws_iam_policy" "apex-default" {
  name = "apex-default"
  path = "/"
  description = "apex default"
  policy = "${data.aws_iam_policy_document.apex-default.json}"
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
      "events:*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "nodejs-ko-twitter_lambda_logs" {
  name = "nodejs-ko-twitter_lambda_logs"
  path = "/"
  description = "Allow lambda_function to utilize CloudWatchLogs. Created by apex(1)."
  policy = "${data.aws_iam_policy_document.nodejs-ko-twitter_lambda_logs.json}"
}
data "aws_iam_policy_document" "nodejs-ko-twitter_lambda_logs" {
  statement {
    actions = [
      "logs:*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "sideeffect_lambda_logs" {
  name = "sideeffect_lambda_logs"
  path = "/"
  description = "Allow lambda_function to utilize CloudWatchLogs. Created by apex(1)."
  policy = "${data.aws_iam_policy_document.sideeffect_lambda_logs.json}"
}
data "aws_iam_policy_document" "sideeffect_lambda_logs" {
  statement {
    actions = [
      "logs:*"
    ]

    resources = [
      "*"
    ]
  }
}

# policy attachment
resource "aws_iam_policy_attachment" "apex-default-policy-attachment" {
  name = "apex-default-policy-attachment"
  policy_arn = "arn:aws:iam::410655858509:policy/apex-default"
  groups = ["${aws_iam_group.apex.name}"]
  users = []
  roles = []
}

resource "aws_iam_policy_attachment" "nodejs-ko-twitter_lambda_logs-policy-attachment" {
  name = "nodejs-ko-twitter_lambda_logs-policy-attachment"
  policy_arn = "arn:aws:iam::410655858509:policy/nodejs-ko-twitter_lambda_logs"
  groups = []
  users = []
  roles = ["${aws_iam_role.nodejs-ko-twitter_lambda_function.name}"]
}

resource "aws_iam_policy_attachment" "sideeffect_lambda_logs-policy-attachment" {
  name = "sideeffect_lambda_logs-policy-attachment"
  policy_arn = "arn:aws:iam::410655858509:policy/sideeffect_lambda_logs"
  groups = []
  users = []
  roles = ["${aws_iam_role.sideeffect_lambda_function.name}"]
}

resource "aws_iam_policy_attachment" "AWSLambdaFullAccess-policy-attachment" {
  name = "AWSLambdaFullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
  groups = []
  users = ["${aws_iam_user.outsider.name}"]
  roles = []
}

resource "aws_iam_policy_attachment" "IAMFullAccess-policy-attachment" {
  name = "IAMFullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  groups = []
  users = ["${aws_iam_user.outsider.name}"]
  roles = []
}

resource "aws_iam_policy_attachment" "AmazonS3FullAccess-policy-attachment" {
  name = "AmazonS3FullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  groups = []
  users = ["${aws_iam_user.outsider.name}"]
  roles = ["${aws_iam_role.nodejs-ko-twitter_lambda_function.name}"]
}

resource "aws_iam_policy_attachment" "AdministratorAccess-policy-attachment" {
  name = "AdministratorAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  groups = []
  users = ["${aws_iam_user.outsider.name}"]
  roles = []
}

# group
resource "aws_iam_group" "apex" {
  name = "apex"
  path = "/"
}

resource "aws_iam_group_membership" "apex" {
  name = "apex-group-membership"
  users = ["${aws_iam_user.apex-basic.name}"]
  group = "${aws_iam_group.apex.name}"
}
