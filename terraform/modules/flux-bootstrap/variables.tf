variable "aws_region" {
  type        = string
  description = "aws region"
  default     = "eu-west-1"
}

variable "cluster_name" {
  type        = string
  description = "eks cluster name"
}

variable "github_owner" {
  type        = string
  description = "github owner"
}

variable "repository_name" {
  type        = string
  description = "github repository name"
}

variable "branch" {
  type        = string
  description = "branch name"
  default     = "main"
}

variable "target_path" {
  type        = string
  description = "flux sync target path"
  default     = ""
}

variable "read_only_key" {
  type        = bool
  description = "configure the deploy key with read/write permissions"
  default     = true
}

variable "flux_version" {
  type        = string
  description = "version of flux to bootstrap"
  default     = null
}

variable "use_existing_repository" {
  type        = bool
  description = "bootstrap flux into an existing repository instead of creating a new repository"
}

variable "repository_visibility" {
  type        = string
  description = "repository visibility when creating a new repository (only valid when `use_existing_repository` is set to false)"
  default     = "private"
}

variable "kustomization_patches" {
  type        = string
  description = "kustomization patches to append to the flux kustomiztion file"
  default     = ""
}

variable "commit_author" {
  type        = string
  description = "git commit email"
  default     = null
}

variable "commit_email" {
  type        = string
  description = "git commit email"
  default     = null
}

variable "role" {
  type        = string
  description = "role to use for source controller"
  default     = ""
}
