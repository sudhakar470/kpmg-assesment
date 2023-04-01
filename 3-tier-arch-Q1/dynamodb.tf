#create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb" {
  name = "sudhakar-tf-state"
  billing_mode = "PROVISIONED"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}