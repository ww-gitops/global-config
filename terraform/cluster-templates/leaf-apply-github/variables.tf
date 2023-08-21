
variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "github_token" {
  type        = string
  description = "gitlab token"
  default     = null
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "gitlab owner"
}

variable "repository_name" {
  type        = string
  description = "github repository name"
}

variable "repository_visibility" {
  type        = string
  description = "How visible is the github repo"
  default     = "private"
}

variable "target_path" {
  type        = string
  description = "flux sync target path"
}

variable "flux_sync_directory" {
  type        = string
  description = "directory within target_path to sync flux"
  default     = "flux"
}

variable "git_commit_author" {
  type        = string
  description = "Git commit author (defaults to author value from auth)"
  default     = null
}

variable "git_commit_email" {
  type        = string
  description = "Git commit email (defaults to email value from auth)"
  default     = null
}

variable "git_commit_message" {
  type        = string
  description = "Set custom commit message"
  default     = null
}

variable "resource_name" {
  type        = string
  description = "template resource name"
  default     = ""
}

variable "template_namespace" {
  type        = string
  description = "template namespace"
  default     = ""
}

variable "prefixName" {
  type        = string
  description = "prefix string"
  default     = ""
}

variable "globalGitHubOrg" {
  type        = string
  description = "global config GitHub organziation"
  default     = ""
}

variable "globalGitHubRepo" {
  type        = string
  description = "global config GitHub repository"
  default     = ""
}

variable "globalGitHubBranch" {
  type        = string
  description = "global config GitHub repository branch"
  default     = ""
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

variable "awsTagCreator" {
  type        = string
  description = "AWS creator tag"
  default     = ""
}

variable "awsTagCustomer" {
  type        = string
  description = "AWS customer tag"
  default     = ""
}

variable "awsTagProjectGid" {
  type        = string
  description = "AWS ProjectGid tag"
  default     = ""
}

variable "cset" {
  type        = string
  description = "cluster set"
  default     = ""
}

variable "region" {
  type        = string
  description = "cluster region"
  default     = ""
}

variable "env" {
  type        = string
  description = "cluster env, i.e. dev, staging or prod"
  default     = ""
}

