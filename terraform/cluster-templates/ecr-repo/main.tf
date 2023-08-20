provider "aws" {
  region = var.awsRegion

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
  repo_name                 = var.repo_name
  cluster_oidc_provider_arn = var.cluster_oidc_provider_arn
  cluster_oidc_provider_url = var.cluster_oidc_provider_url
  awsRegion = var.awsRegion
  awsAccountId = var.awsAccountId
  sa_namespace = var.sa_namespace
  service_account = var.service_account
}

