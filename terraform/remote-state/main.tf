provider "aws" {
  region = var.awsRegion

  default_tags {
    tags = merge({
      source  = "Terraform Managed"
      Name = var.bucket_name
    }, var.tags)
  }
}

data "aws_caller_identity" "current" {}

# Commented out due to https://github.com/hashicorp/terraform-provider-aws/issues/23221#issuecomment-1425789967
# This works if the bucket does not exist because the resource creation below creates the bucket in the provider's region
# but if the bucket already exists, even in the same region, the import gets a region mismatch error because it thinks it is in us-east-1

# import {
#   to = aws_s3_bucket.terraform_state
#   id = var.bucket_id
# }

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  versioning_configuration {
    status = "Enabled"
  }
  bucket = aws_s3_bucket.terraform_state.id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encrypt" {
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  bucket = aws_s3_bucket.terraform_state.id
}

resource "aws_s3_bucket_acl" "private_bucket" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf-state-lock" {
  name           = var.bucket_name
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}