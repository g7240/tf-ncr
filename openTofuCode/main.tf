provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

resource "aws_s3_bucket" "private_bucket" {
  bucket = "my-private-bucket-12345" # Change to your preferred bucket name
  acl    = "private"

  tags = {
    Name        = "My Private Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.private_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
