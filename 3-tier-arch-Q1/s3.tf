resource "aws_s3_bucket" "sudhakar-dev-tf-state-nonprod" {
  bucket        = "sudhakar-dev-tf-state-nonprod"
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = local.tags
}