provider "aws" {
  region = var.awsRegion

  default_tags {
    tags = merge({
      source = "Terraform Managed"
    }, var.tags)
  }
}

resource "aws_s3_bucket" "image_versions" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  versioning_configuration {
    status = "Enabled"
  }
  bucket = aws_s3_bucket.image_versions.id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encrypt" {
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  bucket = aws_s3_bucket.image_versions.id
}

resource "aws_s3_bucket_ownership_controls" "image_versions" {
  bucket = aws_s3_bucket.image_versions.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "private_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.image_versions]

  bucket = aws_s3_bucket.image_versions.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.image_versions.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

