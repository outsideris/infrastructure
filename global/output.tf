output "iam_user_apex_basic_name" {
  value = "${aws_iam_user.apex-basic.name}"
}

output "iam_user_apex_basic_arn" {
  value = "${aws_iam_user.apex-basic.arn}"
}

output "iam_user_outsider_name" {
  value = "${aws_iam_user.outsider.name}"
}

output "iam_user_outsider_arn" {
  value = "${aws_iam_user.outsider.arn}"
}