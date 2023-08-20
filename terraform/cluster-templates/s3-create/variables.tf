variable "tags" {
  type        = map(string)
  description = "tags for aws resources"

  default     = {
    customer   = "weaveworks-cx"
    projectGid = "99999"
    creator    = "paul-carlton@weave.works"
  }
}

variable "bucket_name" {
  type = string
}

variable "awsRegion" {
  type        = string
  description = "AWS region"
  default     = ""
}
