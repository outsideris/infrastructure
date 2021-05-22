resource "aws_ecr_repository" "popularconvention" {
  name                 = "popularconvention"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
