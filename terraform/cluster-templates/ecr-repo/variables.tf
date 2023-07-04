variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}

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