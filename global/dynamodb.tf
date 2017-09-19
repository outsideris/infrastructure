// terrafrom state 파일을 lock 테이블
resource "aws_dynamodb_table" "terraform-lock" {
  name           = "SideEffectTerraformStateLock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
