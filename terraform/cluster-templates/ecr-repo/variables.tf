variable "repo_name" {
  type        = string
  description = "ECR Repo name"
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
  default     = ""
}

