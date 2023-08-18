provider "aws" {
  region = var.region

  default_tags {
    tags = merge({
      source  = "Terraform Managed"
      repo = var.repo_name
    }, var.tags)
  }
}

resource "aws_ecr_repository" "repo" {
  name                 = var.repo_name
  force_delete         = true
  image_tag_mutability = "IMMUTABLE"
}

module "aws_ecr_roles" {
  source                    = "../../modules/aws-ecr-roles"
  cluster_name              = var.cluster_name
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  cluster_oidc_provider_url = var.cluster_oidc_provider_url
  awsRegion = var.region
  awsAccountId = var.awsAccountId
  service_account = var.service_account
  namespace = var.sa_namespace
}