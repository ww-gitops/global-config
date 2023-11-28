output "created" {
  value = {
    "bucket_id"    = aws_s3_bucket.terraform_state.id
    "dynamo_table_id" = aws_dynamodb_table.tf-state-lock.id
  }
}

