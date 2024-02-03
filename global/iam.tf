# users

## it's me
resource "aws_iam_user" "outsider" {
  name          = "outsider"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecsInstanceRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_role.json
}

data "aws_iam_policy_document" "ecs_instance_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "ecs_instance_role" {
  name       = "AmazonEC2ContainerServiceforEC2Role"
  roles      = [aws_iam_role.ecs_instance_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "ecsServiceRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
}

data "aws_iam_policy_document" "ecs_service_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "ecs_service_role" {
  name       = "AmazonEC2ContainerServiceforEC2Role"
  roles      = [aws_iam_role.ecs_service_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

## a role for AWS config
resource "aws_iam_role" "config_service" {
  name               = "config-service"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.config_service.json
}

data "aws_iam_policy_document" "config_service" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "config.amazonaws.com",
      ]
    }
  }
}

# policy
resource "aws_iam_policy" "config_service_delivery_permission" {
  name        = "config-service-delivery-permission"
  path        = "/"
  description = "Allow AWS Config to delivery logs"
  policy      = data.aws_iam_policy_document.config_service_delivery_permission.json
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
      aws_s3_bucket.logs.arn,
    ]
  }

  statement {
    actions = [
      "sns:Publish",
    ]

    resources = [
      data.terraform_remote_state.vpc.outputs.sns_topic_config_service_arn,
    ]
  }
}

# policy attachment
resource "aws_iam_policy_attachment" "AWSLambdaFullAccess-policy-attachment" {
  name       = "AWSLambdaFullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
  groups     = []
  users      = [aws_iam_user.outsider.name]
  roles      = []
}

resource "aws_iam_policy_attachment" "IAMFullAccess-policy-attachment" {
  name       = "IAMFullAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  groups     = []
  users      = [aws_iam_user.outsider.name]
  roles      = []
}

resource "aws_iam_policy_attachment" "AdministratorAccess-policy-attachment" {
  name       = "AdministratorAccess-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  groups     = []
  users      = [aws_iam_user.outsider.name]
  roles      = []
}

resource "aws_iam_policy_attachment" "AWSConfigRole-policy-attachment" {
  name       = "AWSConfigRole-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
  groups     = []
  users      = []
  roles      = [aws_iam_role.config_service.name]
}

resource "aws_iam_policy_attachment" "config_service_delivery_permission_attachment" {
  name       = "config-service-delivery-permission-attachment"
  policy_arn = aws_iam_policy.config_service_delivery_permission.arn
  groups     = []
  users      = []
  roles      = [aws_iam_role.config_service.name]
}

# group

# instance profiles
resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "ecsInstanceRole"
  role = aws_iam_role.ecs_instance_role.name
}

