variable "region" {
  type        = string
  description = "AWS region for cluster"
  default     = "us-east-1"
}

variable "repo_name" {
  type        = string
  description = "EKS cluster name"
}
