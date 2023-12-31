variable "bucket_name" {
  type        = string
  description = "S3 Bucket name"
}

variable "bucket_id" {
  type        = string
  description = "S3 Bucket id, use if exists already"
  default = "none"
}

variable "tags" {
  type        = map(string)
  description = "resource specific tags"
  default     = {
    customer   = "weaveworks-cx"
    projectGid = "99999"
    creator    = "paul-carlton@weave.works"
  }
}

variable "awsAccountId" {
  type        = string
  description = "AWS account id"
  default     = ""
}

variable "awsRegion" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}

