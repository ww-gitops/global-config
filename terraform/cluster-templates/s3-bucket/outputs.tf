output "created" {
  value = {
    "bucket"       = aws_s3_bucket.terraform_state.id
  }
}

