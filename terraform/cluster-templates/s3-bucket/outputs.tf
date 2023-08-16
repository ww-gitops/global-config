output "image-verisons" {
  value = {
    "bucket"       = aws_s3_bucket.image_versions.id
  }
}

