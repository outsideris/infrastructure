resource "aws_iam_role" "app_runner_ecr" {
  name               = "AppRunnerECRAccess"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.app_runner_ecr_assume.json
}

data "aws_iam_policy_document" "app_runner_ecr_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["build.apprunner.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "app_runner_ecr" {
  name        = "ecr-access-policy"
  description = "ECR access"
  policy      = data.aws_iam_policy_document.app_runner_ecr_policy.json
}

data "aws_iam_policy_document" "app_runner_ecr_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "app_runner_ecr" {
  role       = aws_iam_role.app_runner_ecr.name
  policy_arn = aws_iam_policy.app_runner_ecr.arn
}

