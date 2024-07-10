provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "private_bucket" {
  bucket = "my-private-bucket-fjjdxq3o90p"
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
