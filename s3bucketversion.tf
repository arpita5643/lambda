resource "aws_s3_bucket_versioning" "example_bucket" {
  bucket = "example-bucket"
  acl    = "private"
    enabled = true
  }