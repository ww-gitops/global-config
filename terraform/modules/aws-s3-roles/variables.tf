variable "bucket_name" {
  type        = string
  description = "name of cluster to associate permissions with"
}

variable "cluster_name" {
  type        = string
  description = "name of cluster to associate permissions with"
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

variable "cluster_oidc_provider_url" {
  type        = string
  description = "url for cluster oidc provider"
}

variable "cluster_oidc_provider_arn" {
  type        = string
  description = "arn for cluster oidc provider"
}

variable "service_account" {
  type        = string
  description = "kubernetes service account"
  default     = "source-controller"
}

variable "namespace" {
  type        = string
  description = "namespace for kubernetes service account"
  default     = "flux-system"
}

