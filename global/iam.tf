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
